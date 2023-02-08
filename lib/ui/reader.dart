import 'package:flutter/material.dart';
import 'package:zreader/domain/book.dart';

class ReaderWidget extends StatefulWidget {
  BookDO book;
  ReaderWidget(this.book);

  @override
  State<StatefulWidget> createState() {
    return ReaderState();
  }

}

class ReaderState extends State<ReaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.book.name),
      ),
    );
  }
}