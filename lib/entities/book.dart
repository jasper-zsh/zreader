import 'package:floor/floor.dart';

@entity
class Book {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;

  Book(this.id, this.name);
}