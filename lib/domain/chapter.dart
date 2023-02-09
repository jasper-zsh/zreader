import 'package:uuid/uuid.dart';
import 'package:zreader/database.dart';
import 'package:zreader/entities/chapter.dart';
import 'package:zreader/service_locator.dart';

class ChapterDO {
  Chapter chapter;

  ChapterDO(this.chapter);

  Future<void> save() async {
    var repo = locator<AppDatabase>().chapterRepository;
    if (chapter.id == null) {
      chapter.id = const Uuid().v1();
      await repo.insertChapter(chapter);
    } else {
      await repo.updateChapter(chapter);
    }
  }
}