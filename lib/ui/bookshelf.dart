import 'package:flutter/material.dart';
import 'package:event/event.dart';
import 'package:zreader/database.dart';
import 'package:zreader/domain/book.dart';
import 'package:zreader/entities/book.dart';
import 'package:zreader/service_locator.dart';
import 'package:zreader/services/book.dart';
import 'package:zreader/ui/reader.dart';

var bookshelfUpdated = Event();

class Bookshelf extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookshelfState();
  }

}

class BookshelfState extends State<Bookshelf> {
  BookshelfState() {
    bookshelfUpdated.subscribe((args) {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookDO>>(
      future: locator<BookService>().getAllBooks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Text("Loading..."),
          );
        }
        return GridView.count(
          restorationId: 'bookshelf_offset',
          crossAxisCount: 3,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          padding: const EdgeInsets.all(8),
          children: snapshot.requireData.map((book) {
            return _buildBook(context, book);
          }).toList(),
        );
      },
    );
  }

  Widget _buildBook(BuildContext context, BookDO book) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ReaderWidget(book);
        }));
      },
      child: Card(
        child: Text(book.name),
      ),
    );
  }
}