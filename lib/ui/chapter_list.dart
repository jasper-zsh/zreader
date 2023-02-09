import 'package:flutter/material.dart';
import 'package:zreader/domain/book.dart';
import 'package:zreader/domain/chapter.dart';

typedef OnChapterSelected = void Function(ChapterDO chapter);

class ChapterListWidget extends StatelessWidget {
  BookDO book;
  OnChapterSelected? onChapterSelected;

  ChapterListWidget(this.book, {this.onChapterSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("章节列表"),
      ),
      body: FutureBuilder(
          future: book.chapterProvider!.listAllChapters(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: Text("Loading..."),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return _buildChapterItem(context, snapshot.requireData[index]);
              },
              itemCount: snapshot.requireData.length
            );
          }
      ),
    );
  }

  Widget _buildChapterItem(BuildContext context, ChapterDO chapter) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (this.onChapterSelected != null) {
          this.onChapterSelected!(chapter);
          Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(chapter.name),
      ),
    );
  }

}