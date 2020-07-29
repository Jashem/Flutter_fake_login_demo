import 'dart:io';

class FakeHttpClient {
  var _userJson =
      '{"id":1,"firstName":"Jhon","lastName":"Doe","email":"test@test.com","phone":"01256978945","imageUrl":"https://via.placeholder.com/300"}';
  Future<String> login(String email, String password) async {
    await Future.delayed(Duration(milliseconds: 500));
    //! No Internet Connection
    // throw SocketException('No Internet');
    //! 404
    // throw HttpException('404');
    //! Invalid JSON (throws FormatException)
    // return 'abcd';

    if (email != "test@test.com" || password != "password") {
      throw HttpException("401");
    }
    return _userJson;
  }
}
