import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxi_kg/models/user.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

enum AuthState {
  loading,
  notFound,
  error,
  errorNotRecognized,
  sendCode,
  success,
  sendVerifyLink,
}

class AuthService {
  AuthService(authState) {
    _authState.add(authState);
  }

  final Map<int, AuthState> _errorCodes = {
    404: AuthState.notFound,
    200: AuthState.sendCode,
  };

  final _authState = StreamController<AuthState>();
  Stream<AuthState> authStateChanges() => _authState.stream;

  Future<void> sendCode({required String number}) async {
    try {
      final response = await http.post(
        getRoute('/send-code-to-number'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'number': number,
        }),
      );
      _errorCodes.keys.contains(response.statusCode)
          ? _authState.add(_errorCodes[response.statusCode] ?? AuthState.errorNotRecognized)
          : _authState.add(AuthState.error);
    } catch (e) {
      _authState.add(AuthState.errorNotRecognized);
    }
  }

  Future<void> sendVerifyLink() async {
    _authState.add(AuthState.sendVerifyLink);
  }

  Future<dynamic> loginWithEmail({required String email, required String code}) async {
    try {
      var response = await http.post(
        getRoute('/login-with-email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
        }),
      );
      return response.statusCode == 200 ? User(email: response.body) : response.body;
    } catch (e) {
      return null;
    }
  }

  // Future<bool> loginWithNumber({required String number}) async {
  //   _userNumber = number;
  //   logServer('Авторизация пользователя $number');
  //   logServer('Адрес сервера ${getRoute('/login')}');
  //   try {
  //     final response = await http.post(
  //       getRoute('/login-with-number'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'email': number,
  //       }),
  //     );
  //     logServer('Ответ сервера: $response');
  //     if (response.statusCode == 200) {
  //       // Если сервер возвращает ответ OK, то парсим JSON.
  //       print('Авторизация пользователя $number успешна');
  //       return true;
  //     } else {
  //       logServer('Код ошибки: ${response.statusCode}');
  //       // Если ответ не OK, то выкидываем ошибку.
  //       throw Exception(response.body);
  //     }
  //   } catch (e) {
  //     logServer('ОШИБКА: ${e.toString()}');
  //     logServer(e.toString());
  //     return false;
  //   }
  // }

  // Future<bool> register(
  //     {required String email, required String username}) async {
  //   logInfo('Регистрация нового пользователя $email');
  //   try {
  //     final response = await http.post(
  //       getRoute('/register'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'email': email,
  //         'username': username,
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       // Если сервер возвращает ответ OK, то парсим JSON.
  //       print('Регистрация пользователя $email успешна');
  //       return true;
  //     } else {
  //       logServer('Код ошибки: ${response.statusCode}');
  //       // Если ответ не OK, то выкидываем ошибку.
  //       throw Exception(response.body);
  //     }
  //   } catch (e) {
  //     logServer('ОШИБКА: ${e.toString()}');
  //     logInfo('Ошибка регистрации пользователя $email');
  //     return false;
  //   }
  // }

  // Future<bool> restore(email) async {
  //   try {
  //     return true;
  //   } catch (e) {}
  //   return false;
  // }

  // Future<bool> logout() async {
  //   return true;
  // }
  void dispose() => _authState.close();
}
