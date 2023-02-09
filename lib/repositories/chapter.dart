import 'package:floor/floor.dart';
import 'package:zreader/entities/chapter.dart';

@dao
abstract class ChapterRepository {
  @Query('SELECT * FROM Chapter WHERE bookId = :bookId')
  Future<List<Chapter>> findByBookId(int bookId);

  @insert
  Future<int> insertChapter(Chapter chapter);
  Future<void> save(Chapter chapter) async {
    var id = await insertChapter(chapter);
    chapter.id = id;
  }

  @Query('DELETE FROM Chapter WHERE bookId = :bookId')
  Future<void> deleteByBookId(int bookId);

  @insert
  Future<List<int>> insertChapters(List<Chapter> chapters);
  Future<void> saveChapters(List<Chapter> chapters) async {
    var ids = await insertChapters(chapters);
    for (var i = 0; i < ids.length; i ++) {
      chapters[i].id = ids[i];
    }
  }

  @transaction
  Future<void> clearAndInsertChapters(int bookId, List<Chapter> chapters) async {
    await deleteByBookId(bookId);
    await saveChapters(chapters);
  }
}