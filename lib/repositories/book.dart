import 'package:floor/floor.dart';
import 'package:zreader/entities/book.dart';

@dao
abstract class BookRepository {
  @Query('SELECT * FROM Book WHERE id = :id')
  Future<Book?> findById(String id);
  @Query('SELECT * FROM Book')
  Future<List<Book>> findAllBooks();
  @Query('SELECT * FROM Book WHERE contentUri = :contentUri')
  Future<Book?> findByContentUri(String contentUri);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertBook(Book book);
  Future<void> save(Book book) async {
    var id = await insertBook(book);
    book.id = id;
  }
}