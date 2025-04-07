import 'package:firstproject/src/domain/dtos/book_dto.dart';
import 'package:firstproject/src/domain/models/book_model.dart';
import 'package:firstproject/src/repositories/database_helper.dart';
import 'package:firstproject/src/services/book_service.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:vaden/vaden.dart';

@Repository()
class BookRepository {
  final DatabaseHelper _db = DatabaseHelper();
  
  final BookService service;
  
  BookRepository(this.service);

  List<BookModel> getAll() {
    var books = _db.getAll();
    var response = <BookModel>[];
    books.forEach((element) {
      response.add(service.deserialize(element));
    },);

    return response;
  }

  Response registerBook(BookDto dto) {
    try {
      if (dto.name.contains("Barba")) {
        return Response.badRequest();
      }
      _db.insert(dto.name, dto.year);
      return Response.ok("${dto.name} Registrado");
    } on SqliteException catch (e) {
      return Response.badRequest(body: e.message);
    }
  }

  Response getBook(int id) {
    try {
      final book = _db.getOneBook(id);
      if (book.isNotEmpty) {
        final body = service.deserialize(book.first);
        return Response.ok(service.serialize(body));
      }
      return Response.badRequest();
    } on SqliteException catch (e) {
      return Response.badRequest();
    }
  }

  Response deleteBook(int id) {
    final book = _db.getOneBook(id);
    if (book.isNotEmpty) {
      _db.deleteBook(id);
      final body = service.deserialize(book.first);
      return Response.ok(service.serialize(body));
    }
    return Response.badRequest();
  }
}
