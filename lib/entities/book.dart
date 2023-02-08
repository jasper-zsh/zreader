import 'package:floor/floor.dart';

@entity
@Index(value: ['contentUri'], unique: true)
class Book {
  @PrimaryKey(autoGenerate: true)
  int id;
  String name;
  String contentUri;

  Book(this.id, this.name, this.contentUri);
}