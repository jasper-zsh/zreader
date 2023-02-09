import 'package:floor/floor.dart';

@entity
@Index(value: ['bookId'])
class Chapter {
  @PrimaryKey(autoGenerate: true)
  int? id;
  int bookId;
  String name;
  String provider;
  String data;

  Chapter({
    this.id,
    required this.bookId,
    required this.name,
    required this.provider,
    required this.data
  });
}