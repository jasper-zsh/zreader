import 'package:floor/floor.dart';

@Entity(
  indices: [
    Index(value: ['contentUri'], unique: true)
  ]
)
class Book {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String contentUri;

  Book({
    this.id,
    required this.name,
    required this.contentUri
  });
}