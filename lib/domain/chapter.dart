import 'package:zreader/database.dart';
import 'package:zreader/entities/chapter.dart';
import 'package:zreader/service_locator.dart';

import 'chapter_provider.dart';

class ChapterDO {
  Chapter chapter;
  ChapterProvider provider;
  String? content;

  ChapterDO(this.chapter, this.provider);

  String get name {
    return chapter.name;
  }

  String get data {
    return chapter.data;
  }

  Future<String> loadContent() async {
    if (content == null) {
      content = await provider.loadContent(this);
    }
    return content!;
  }

  Future<void> save() async {
    var repo = locator<AppDatabase>().chapterRepository;
    await repo.save(chapter);
  }
}