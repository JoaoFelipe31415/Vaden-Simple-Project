import 'package:firstproject/src/domain/models/book_model.dart';
import 'package:vaden/vaden.dart';

@Service()
class BookService {

  final DSON dson;

  BookService(this.dson);

  Map<String,dynamic> serialize(BookModel book){
    final body = dson.toJson<BookModel>(book);
    return body;
  }

  BookModel deserialize(Map<String, dynamic> body){
    final book = dson.fromJson<BookModel>(body);
    return book;
  }
  

}