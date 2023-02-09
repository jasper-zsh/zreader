import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zreader/domain/book.dart';
import 'package:zreader/domain/chapter.dart';
import 'package:zreader/ui/chapter_list.dart';
import 'package:zreader/ui/page.dart';

class ReaderWidget extends StatefulWidget {
  BookDO book;
  ReaderWidget(this.book): super(key: Key(book.id.toString()));

  @override
  State<StatefulWidget> createState() {
    return ReaderState();
  }

}

class ReaderState extends State<ReaderWidget> {
  bool showMenus = false;
  ChapterDO? chapter;
  Future<String>? contentFuture;

  @override
  Widget build(BuildContext context) {
    var layers = <Widget>[Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              showMenus = true;
            });
          },
          child: chapter != null ? PageWidget(chapter!) : Center(
            child: Text(widget.book.name),
          ),
        ),
      ),
    )];
    if (showMenus) {
      layers.add(Scaffold(
        appBar: AppBar(
          title: Text(widget.book.name),
        ),
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              showMenus = false;
            });
          },
          child: Container(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: "章节"
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "设置"
            )
          ],
          onTap: (idx) {
            switch (idx) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChapterListWidget(widget.book, onChapterSelected: (chapter) {
                    setState(() {
                      this.chapter = chapter;
                      contentFuture = chapter.loadContent();
                      showMenus = false;
                    });
                  },);
                }));
                break;
            }
          },
        ),
      ));
    }
    return Stack(
      children: layers,
    );
  }
}