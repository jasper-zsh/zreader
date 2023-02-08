import 'package:flutter/material.dart';
import 'package:zreader/entities/local_file.dart';
import 'package:zreader/repositories/local_file.dart';
import 'package:zreader/service_locator.dart';

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
          child: ListView.builder(
            itemCount: snapshot.requireData.length,
            itemBuilder: (context, index) {
              return _buildFileItem(context, snapshot.requireData[index]);
            },
          ),
        );
      }
    );
  }

  Widget _buildFileItem(BuildContext context, LocalFile file) {
    return Container(
      height: 100,
      child: Center(
        child: Text(file.name),
      ),
    );
  }
}