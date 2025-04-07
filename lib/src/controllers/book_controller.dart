import 'package:firstproject/src/domain/dtos/book_dto.dart';
import 'package:firstproject/src/domain/models/book_model.dart';
import 'package:firstproject/src/middlewares/book_middleware.dart';
import 'package:firstproject/src/repositories/book/book_repository.dart';
import 'package:vaden/vaden.dart';

@UseMiddleware([BookMiddleware])
@Api(tag: 'Books', description: 'Books Endpoints')
@Controller('/store')
class BookController {
  final BookRepository repository;

  BookController(this.repository);

  @Get('/')
  List<BookModel> getBooks() {
    return repository.getAll();
  }

  @Get("/<id>")
  Response getBook(@Param() int id) {
    return repository.getBook(id);
  }

  @ApiOperation(summary: "Create Book", description: "Description")   
  @UseGuards([BookGuard])
  @Post('/')
  Response postBook(@Body() BookDto bookDto) {
    return repository.registerBook(bookDto);
  }

  @Delete('/<id>')
  Response deleteBook(@Param() int id) {
    return repository.deleteBook(id);
  }
}
