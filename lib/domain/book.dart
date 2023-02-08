import 'package:zreader/entities/book.dart';

class BookDO {
  Book book;

  BookDO(this.book);

  String get name {
    return book.name;
  }
}