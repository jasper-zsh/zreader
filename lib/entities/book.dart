import 'package:floor/floor.dart';

@entity
@Index(value: ['contentUri'], unique: true)
class Book {
  @primaryKey
  String? id;
  String name;
  String contentUri;

  Book({
    this.id,
    required this.name,
    required this.contentUri
  });
}