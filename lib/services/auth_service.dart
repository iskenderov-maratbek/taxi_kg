import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:taxi_kg/models/user.dart';
import 'package:taxi_kg/providers/providers.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

enum AuthState {
  loading,
  notFound,
  error,
  // invalidErrorCode,
  sendCodeEmail,
  // sendCodePhone,
  // sendVerifyLink,
  // autoSendCooldown,
}

enum AuthMethod {
  email,
  phone,
  none,
}

enum TimerState {
  run,
  cooldown,
}

String socket = 'http://192.168.8.100:3000';

class AuthService {
  final dio = Dio();
  final Map<AuthMethod, String> _selectedMethod = {
    for (var value in AuthMethod.values) value: value.toString().split('.')[1]
  };
  final Map<AuthMethod, String?> _userdata = {for (var value in AuthMethod.values) value: null};
  final _authMethod;
  AuthService() {
    
    _authState.add(AuthState.loading);
    // _authMethod.add(AuthMethod.none);
    dio.options.validateStatus = (status) {
      return status == 200;
    };
  }

  final _timerState = StreamController<TimerState>();
  Stream<TimerState> timerStateChanges() => _timerState.stream;

  final _authState = StreamController<AuthState>();
  Stream<AuthState> authStateChanges() => _authState.stream;

  Future<void> sendCode({required String userdata, bool isPhone = false}) async {
    _authState.add(AuthState.loading);
    try {
      dio.options.headers['Authorization'] = 'Bearer JWT_TOKEN}';
      logServer('Start request to send confirm-code-email');
      await dio.post(
        '$socket/send-code',
        data: jsonEncode(<String, dynamic>{
          isPhone ? 'phone' : 'email': userdata,
           _selectedMethod[_authMethod]!: ,
        }),
      );
      _authState.add(AuthState.sendCodeEmail);
      _timerState.add(TimerState.run);
      isPhone ? _phone = userdata : _email = userdata;
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          _authState.add(AuthState.notFound);
          break;
        case 422:
          _timerState.add(TimerState.cooldown);
          _authState.add(AuthState.sendCodeEmail);
          Future.delayed(const Duration(seconds: 3), () {
            _timerState.add(TimerState.run);
          });
          break;
        default:
          _authState.add(AuthState.error);
          break;
      }
    }
  }

  reSendCode() async {
    try {
      dio.options.headers['Authorization'] = 'Bearer JWT_TOKEN}';
      logServer('Start request to send confirm-code-email');
      if (_userdata[_authMethod] != null) {
        await dio.post(
          '$socket/send-code-email',
          data: jsonEncode(<String, dynamic>{
            _selectedMethod[_authMethod]!: _userdata[_authMethod],
          }),
        );
      } else {
        throw Exception('No userdata');
      }

      _authState.add(AuthState.sendCodeEmail);
      _timerState.add(TimerState.run);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          _authState.add(AuthState.notFound);
          break;
        case 422:
          _timerState.add(TimerState.cooldown);
          _authState.add(AuthState.sendCodeEmail);
          Future.delayed(const Duration(seconds: 3), () {
            _timerState.add(TimerState.run);
          });
          break;
        default:
          _authState.add(AuthState.error);
          break;
      }
    }
  }

  // Future<void> sendVerifyLink() async {
  //   _authState.add(AuthState.sendVerifyLink);
  // }

  // Future<dynamic> loginWithEmail({required String email, required String code}) async {
  //   try {
  //     var response = await http.post(
  //       getRoute('/login-with-email'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'email': email,
  //       }),
  //     );
  //     return response.statusCode == 200 ? User(email: response.body) : response.body;
  //   } catch (e) {6
  //     return null;
  //   }
  // }
  Future<dynamic> auth({required String code}) async {
    try {
      _authState.add(AuthState.loading);
      // dio.options.headers['Authorization'] = 'Bearer JWT_TOKEN}';
      logServer('Start request to send confirm-code');
      await dio.post(
        '$socket/confirm-code',
        data: jsonEncode(<String, dynamic>{
          'email': _email,
          'code': code,
        }),
      );
      User(email: _email!);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 404:
          _authState.add(AuthState.notFound);
          break;
        case 422:
          _timerState.add(TimerState.cooldown);
          _authState.add(AuthState.sendCodeEmail);
          Future.delayed(const Duration(seconds: 3), () {
            _timerState.add(TimerState.run);
          });
          break;
        default:
          _authState.add(AuthState.error);
          break;
      }
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
  void dispose() {
    _authState.close();
    _timerState.close();
  }
}
