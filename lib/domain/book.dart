import 'dart:io';

import 'package:uuid/uuid.dart';
import 'package:zreader/database.dart';
import 'package:zreader/domain/chapter_providers/txt_chapter_provider.dart';
import 'package:zreader/entities/book.dart';
import 'package:zreader/service_locator.dart';

import 'chapter_provider.dart';

class BookDO {
  Book book;
  ChapterProvider? chapterProvider;

  BookDO(this.book) {
    var uri = Uri.parse(book.contentUri);
    switch (uri.path.split('.').last) {
      case 'txt':
        chapterProvider = TxtChapterProvider(this, File(Uri.decodeComponent(uri.path)));
        break;
    }
  }

  int? get id {
    return book.id;
  }

  String get name {
    return book.name;
  }

  Future<void> save() async {
    var repo = locator<AppDatabase>().bookRepository;
    await repo.save(book);
  }
}