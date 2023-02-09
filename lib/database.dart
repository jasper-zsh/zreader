import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:zreader/entities/book.dart';
import 'package:zreader/entities/chapter.dart';
import 'package:zreader/repositories/book.dart';
import 'package:zreader/repositories/chapter.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Book, Chapter])
abstract class AppDatabase extends FloorDatabase {
  BookRepository get bookRepository;
  ChapterRepository get chapterRepository;
}