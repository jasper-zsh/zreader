import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:zreader/domain/chapter.dart';

class BookPage {
  ChapterDO chapter;
  double width, height;
  int start;
  int end;
  int padding;
  Widget? image;

  BookPage({
    required this.chapter,
    required this.start,
    required this.width,
    required this.height,
    this.padding = 8
  }): end = start;

  Future<Widget> render() async {
    if (image != null) {
      return image!;
    }
    var w = width - padding * 2;
    var h = height - padding * 2;
    var content = await chapter.loadContent();

    var rec = ui.PictureRecorder();
    var canvas = Canvas(rec);

    pbFactory() {
      return ui.ParagraphBuilder(ui.ParagraphStyle(
      ))..pushStyle(ui.TextStyle(
        color: Colors.black,
        fontSize: 16,
      ));
    }
    var cur = start;
    var step = 20;
    ui.Paragraph? validParagraph;
    while (true) {
      cur += step;
      var pb = pbFactory();
      if (start == 0) {
        pb.pushStyle(ui.TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
        ));
        pb.addText(chapter.name);
        pb.addText("\n\n");
        pb.pop();
      }
      pb.addText(content.substring(start, cur));
      var p = pb.build();
      p.layout(ui.ParagraphConstraints(width: w));
      if (p.height < h) {
        validParagraph = p;
      } else if (step == 1) {
        break;
      } else {
        cur -= step;
        step = (step / 2).ceil();
      }
    }
    if (validParagraph != null) {
      canvas.drawParagraph(validParagraph, Offset(padding.toDouble(), padding.toDouble()));
    }

    var pic = rec.endRecording();
    var img = await pic.toImage(width.floor(), height.floor());
    var data = await img.toByteData(format: ui.ImageByteFormat.png);
    image = Image.memory(
      data!.buffer.asUint8List(),
      width: width,
      height: height,
    );
    return image!;
  }
}