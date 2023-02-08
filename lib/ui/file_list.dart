import 'package:flutter/material.dart';
import 'package:zreader/database.dart';
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
      onTap: () {
        locator<AppDatabase>().bookRepository.save(Book(0, file.name, file.toContentUri()));
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