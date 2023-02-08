import 'package:zreader/database.dart';
import 'package:zreader/domain/book.dart';
import 'package:zreader/repositories/book.dart';
import 'package:zreader/service_locator.dart';

class BookService {
  final BookRepository bookRepository;

  BookService(this.bookRepository);

  Future<List<BookDO>> getAllBooks() async {
    var books = await bookRepository.findAllBooks();
    return books.map((book) {
      return BookDO(book);
    }).toList();
  }
}