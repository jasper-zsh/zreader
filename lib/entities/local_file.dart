import 'dart:io';

class LocalFile {
  String path;

  LocalFile(this.path);

  String get name {
    return path.split(Platform.pathSeparator).last;
  }
}