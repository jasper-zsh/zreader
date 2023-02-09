import 'package:zreader/domain/chapter.dart';

abstract class ChapterProvider {
  Future<List<ChapterDO>> listAllChapters();
  Future<void> parse();
}