import 'package:floor/floor.dart';
import 'package:zreader/entities/book.dart';

@dao
abstract class BookRepository {
  @Query('SELECT * FROM Book')
  Future<List<Book>> findAllBooks();
  @Query('SELECT * FROM Book WHERE contentUri = :contentUri')
  Future<Book?> findByContentUri(String contentUri);
  @insert
  Future<void> save(Book book);
}