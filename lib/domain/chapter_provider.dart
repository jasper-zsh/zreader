import 'package:zreader/domain/chapter.dart';

abstract class ChapterProvider {
  Future<List<ChapterDO>> listAllChapters();
  Future<String> loadContent(ChapterDO chapter);
  Future<void> parse();
}