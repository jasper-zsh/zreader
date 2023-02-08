import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:zreader/entities/book.dart';
import 'package:zreader/repositories/book.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Book])
abstract class AppDatabase extends FloorDatabase {
  BookRepository get bookRepository;
}