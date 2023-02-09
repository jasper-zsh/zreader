import 'package:floor/floor.dart';
import 'package:zreader/database.dart';
import 'package:zreader/domain/chapter.dart';
import 'package:zreader/repositories/chapter.dart';
import 'package:zreader/service_locator.dart';

class ChapterService {
  ChapterRepository chapterRepository;

  ChapterService(this.chapterRepository);
}