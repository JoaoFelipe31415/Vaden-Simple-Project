import 'package:vaden/vaden.dart';

@DTO()
class BookModel {
  final int id;
  final String name;
  final int year;

  const BookModel(this.id, this.name, this.year);
}
