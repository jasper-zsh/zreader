import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'package:zreader/database.dart';
import 'package:zreader/domain/book.dart';
import 'package:zreader/entities/book.dart';
import 'package:zreader/entities/local_file.dart';
import 'package:zreader/repositories/local_file.dart';
import 'package:zreader/service_locator.dart';
import 'package:zreader/ui/bookshelf.dart';

class FileList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalFile>>(
      future: locator<LocalFileRepository>().listLocalBookFiles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Text("Loading..."),
          );
        }
        return Container(
          color: Colors.white,
          child: ListView.separated(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) {
              return _buildFileItem(context, snapshot.requireData[index]);
            },
            separatorBuilder: (_, idx) => const Divider(),
          ),
        );
      }
    );
  }

  Widget _buildFileItem(BuildContext context, LocalFile file) {
    return GestureDetector(
      onTap: () async {
        var book = Book(name: file.name, contentUri: file.toContentUri());
        var bookDO = BookDO(book);
        await bookDO.save();
        await bookDO.chapterProvider?.parse();
        bookshelfUpdated.broadcast();
        Navigator.pop(context);
      },
      child: Row(
        children: [
          Column(
            children: [
              Text(file.name, style: TextStyle(
                fontSize: 22,
              ),),
              file.existsInBookshelf ? Text('已在书架') : Container(),
            ],
          )
        ],
      ),
    );
  }
}