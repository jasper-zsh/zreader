import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageWidget> {
  double? width;
  double? height;
  Widget? rendered;

  @override
  Widget build(BuildContext context) {
    if (rendered != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var width = context.size!.width;
        var height = context.size!.height;
        if (width != this.width || height != this.height) {
          setState(() {
            rendered = null;
          });
        }
      });
      return rendered!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      width = context.size!.width;
      height = context.size!.height;
      var rec = ui.PictureRecorder();
      var canvas = Canvas(rec);

      var pbFactory = () {
        return ui.ParagraphBuilder(ui.ParagraphStyle(
        ))..pushStyle(ui.TextStyle(
          color: Colors.black,
          fontSize: 16,
        ));
      };
      var sb = StringBuffer();
      ui.Paragraph? validParagraph;
      while (true) {
        sb.write('Hello paragraph');
        var pb = pbFactory();
        pb.addText(sb.toString());
        var p = pb.build();
        p.layout(ui.ParagraphConstraints(width: width!));
        if (p.height < height!) {
          validParagraph = p;
        } else {
          break;
        }
      }
      if (validParagraph != null) {
        canvas.drawParagraph(validParagraph, Offset.zero);
      }

      var pic = rec.endRecording();
      var img = await pic.toImage(width!.floor(), height!.floor());
      var data = await img.toByteData(format: ui.ImageByteFormat.png);
      setState(() {
        rendered = Image.memory(
          data!.buffer.asUint8List(),
          width: width,
          height: height,
        );
      });
    });
    return Container();
  }
}