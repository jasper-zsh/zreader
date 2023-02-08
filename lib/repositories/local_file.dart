import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zreader/database.dart';
import 'package:zreader/entities/local_file.dart';
import 'package:zreader/service_locator.dart';

class LocalFileRepository {
  Future<List<LocalFile>> listLocalBookFiles() async {
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
    var files = List<LocalFile>.empty(growable: true);
    files.addAll(await _scanDirectory(await getApplicationDocumentsDirectory()));
    if (Platform.isAndroid) {
      var p = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOCUMENTS);
      files.addAll(await _scanDirectory(Directory(p)));
      p = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      files.addAll(await _scanDirectory(Directory(p)));
    } else {
      files.addAll(await _scanDirectory(await getDownloadsDirectory()));
    }
    return files;
  }

  Future<List<LocalFile>> _scanDirectory(Directory? directory) async {
    if (directory == null) {
      return List.empty();
    }
    return await directory.list(recursive: true).where((entity) {
      return entity.path.endsWith(".txt");
    }).asyncMap((event) async {
      var f = LocalFile(event.path);
      var inShelf = await locator<AppDatabase>().bookRepository.findByContentUri(f.toContentUri());
      f.existsInBookshelf = inShelf != null;
      return f;
    }).toList();
  }
}