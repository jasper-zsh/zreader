import 'package:floor/floor.dart';
import 'package:zreader/entities/chapter.dart';

@dao
abstract class ChapterRepository {
  @Query('SELECT * FROM Chapter WHERE bookId = :bookId')
  Future<List<Chapter>> findByBookId(String bookId);
  @insert
  Future<void> insertChapter(Chapter chapter);
  @update
  Future<void> updateChapter(Chapter chapter);
  @Query('DELETE FROM Chapter WHERE bookId = :bookId')
  Future<void> deleteByBookId(String bookId);
}