import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:zreader/database.dart';
import 'package:zreader/domain/book.dart';
import 'package:zreader/domain/chapter.dart';
import 'package:zreader/domain/chapter_provider.dart';
import 'package:zreader/entities/chapter.dart';
import 'package:zreader/service_locator.dart';

part 'txt_chapter_provider.g.dart';

@JsonSerializable()
class TxtChapterData {
  int start;
  int end;

  TxtChapterData(this.start, this.end);

  factory TxtChapterData.fromJson(Map<String, dynamic> json) => _$TxtChapterDataFromJson(json);
  factory TxtChapterData.fromJsonString(String json) => TxtChapterData.fromJson(jsonDecode(json));
  Map<String, dynamic> toJson() => _$TxtChapterDataToJson(this);
}

class TxtChapterProvider extends ChapterProvider {
  static const NAME = 'txt';
  BookDO book;
  File txtFile;
  String? content;

  TxtChapterProvider(this.book, this.txtFile);

  @override
  Future<List<ChapterDO>> listAllChapters() async {
    var chapters = await locator<AppDatabase>().chapterRepository.findByBookId(book.book.id!);
    return chapters.map((e) {
      return ChapterDO(e, this);
    }).toList();
  }

  @override
  Future<void> parse() async {
    var exp = new RegExp(r"第(.*?)章[ ]+(.*?)[\r\n]+");
    var content = await txtFile.readAsString();
    var matches = exp.allMatches(content).toList();
    var chapters = List<ChapterDO>.empty(growable: true);
    for (var i = 0; i < matches.length; i ++) {
      var start = matches[i].end;
      var end = content.length;
      if (i + 1 < matches.length) {
        end = matches[i + 1].start;
      }
      var data = TxtChapterData(start, end);
      var entity = Chapter(
          bookId: book.book.id!,
          name: matches[i].group(0)!.trim(),
          provider: NAME,
          data: jsonEncode(data)
      );
      var chapter = ChapterDO(entity, this);
      chapters.add(chapter);
    }
    await locator<AppDatabase>().chapterRepository.deleteByBookId(book.book.id!);
    chapters.forEach((element) async {
      await element.save();
    });
  }

  @override
  Future<String> loadContent(ChapterDO chapter) async {
    if (content == null) {
      content = await txtFile.readAsString();
    }
    var data = TxtChapterData.fromJsonString(chapter.data);
    return content!.substring(data.start, data.end);
  }
}