import 'dart:io';

class LocalFile {
  String path;
  bool existsInBookshelf;

  LocalFile(this.path): existsInBookshelf = false;

  String get fullName {
    return path.split(Platform.pathSeparator).last;
  }

  String get name {
    return (fullName.split('.')..removeLast()).join('.');
  }

  String get ext {
    return fullName.split('.').last;
  }

  String toContentUri() {
    var uri = Uri(
      scheme: "file",
      path: path,
    );
    return uri.toString();
  }
}