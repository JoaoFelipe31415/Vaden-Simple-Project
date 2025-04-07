import 'dart:async';
import 'package:vaden/vaden.dart';

@Component()
class BookMiddleware extends VadenMiddleware {
  @override
  FutureOr<Response> handler(Request request, Handler handler){
    if (request.headers['Origin'] != 'Sol') {
      return Response.badRequest();
    }

    return handler(request);

  }
 
}

@Component()
class BookGuard extends VadenGuard{
  @override
  FutureOr<bool> canActivate(Request request) {
    if (request.headers['Authorization'] != '123') {
      return false;
    }
    return true;
  }
  
}






