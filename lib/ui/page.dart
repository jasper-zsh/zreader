import 'dart:convert';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zreader/domain/chapter.dart';
import 'package:zreader/entities/book_page.dart';

class PageWidget extends StatefulWidget {
  final ChapterDO chapter;

  PageWidget(this.chapter): super(key: Key(md5.convert(utf8.encode(chapter.content!)).toString()));

  @override
  State<StatefulWidget> createState() {
    return PageState();
  }
}

class PageState extends State<PageWidget> {
  double? width;
  double? height;
  BookPage? bookPage;
  Future<Widget>? imageFuture;

  @override
  Widget build(BuildContext context) {
    if (bookPage != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        var width = context.size!.width;
        var height = context.size!.height;
        if (width != this.width || height != this.height) {
          setState(() {
            bookPage = null;
          });
        }
      });
      return _buildPage(context);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      width = context.size!.width;
      height = context.size!.height;
      setState(() {
        bookPage = BookPage(
          chapter: widget.chapter,
          start: 0,
          width: width!,
          height: height!,
          padding: 12
        );
        imageFuture = bookPage!.render();
      });
    });
    return Container();
  }

  Widget _buildPage(BuildContext context) {
    return FutureBuilder(
      future: imageFuture!,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Text("Rendering..."),
          );
        }
        return snapshot.requireData;
      },
    );
  }
}