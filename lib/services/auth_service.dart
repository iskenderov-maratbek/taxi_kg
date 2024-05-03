import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

class AuthService extends ChangeNotifier {
  String? _userEmail;
  String? _userNumber;
  BuildContext? _context;

  AuthService(BuildContext context) {
    _context = context;
    logInfo('Сервис авторизации запущен');
  }

  checkAuth() {
    logInfo('Проверка токена авторизации');
    return false;
  }

  Future<bool> sendVerifyCode({required String code}) async {
    _context?.mounted;
    logServer('Отправка кода авторизации: $code');
    logServer('Адрес сервера ${getRoute('/verify')}');
    try {
      final response = await http.post(
        getRoute('/verify-code'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'verifyCode': code,
          'email': _userEmail,
        }),
      );
      logServer('Ответ сервера: $response');
      if (response.statusCode == 200) {
        // Если сервер возвращает ответ OK, то парсим JSON.
        print('Код подтвержден!');
        return true;
      } else {
        logServer('Код ошибки: ${response.statusCode}');
        // Если ответ не OK, то выкидываем ошибку.
        throw Exception(response.body);
      }
    } catch (e) {
      logServer('ОШИБКА: ${e.toString()}');
      logServer(e.toString());
      return false;
    }
  }

  Future<String?> loginWithEmail({required String email}) async {
    _userEmail = email;
    logServer('Авторизация пользователя $email');
    logServer('Адрес сервера ${getRoute('/login')}');
    try {
      final response = await http.post(
        getRoute('/login-with-email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
        }),
      );
      logServer('Ответ сервера: $response');
      if (response.statusCode == 200) {
        // Если сервер возвращает ответ OK, то парсим JSON.
        print('Авторизация пользователя $email успешна');
        return null;
      } else if (response.statusCode == 404) {
        return response.body;
      } else {
        logServer('Код ошибки: ${response.statusCode}');
        // Если ответ не OK, то выкидываем ошибку.
        throw Exception(response.body);
      }
    } catch (e) {
      logServer('ОШИБКА: ${e.toString()}');
      logServer(e.toString());
      return 'Ошибка, пожалуйста, попробуйте снова';
    }
  }

  Future<bool> loginWithNumber({required String number}) async {
    _userNumber = number;
    logServer('Авторизация пользователя $number');
    logServer('Адрес сервера ${getRoute('/login')}');
    try {
      final response = await http.post(
        getRoute('/login-with-number'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': number,
        }),
      );
      logServer('Ответ сервера: $response');
      if (response.statusCode == 200) {
        // Если сервер возвращает ответ OK, то парсим JSON.
        print('Авторизация пользователя $number успешна');
        return true;
      } else {
        logServer('Код ошибки: ${response.statusCode}');
        // Если ответ не OK, то выкидываем ошибку.
        throw Exception(response.body);
      }
    } catch (e) {
      logServer('ОШИБКА: ${e.toString()}');
      logServer(e.toString());
      return false;
    }
  }

  Future<bool> register(
      {required String email, required String username}) async {
    logInfo('Регистрация нового пользователя $email');
    try {
      final response = await http.post(
        getRoute('/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'username': username,
        }),
      );
      if (response.statusCode == 200) {
        // Если сервер возвращает ответ OK, то парсим JSON.
        print('Регистрация пользователя $email успешна');
        return true;
      } else {
        logServer('Код ошибки: ${response.statusCode}');
        // Если ответ не OK, то выкидываем ошибку.
        throw Exception(response.body);
      }
    } catch (e) {
      logServer('ОШИБКА: ${e.toString()}');
      logInfo('Ошибка регистрации пользователя $email');
      return false;
    }
  }

  Future<bool> restore(email) async {
    try {
      return true;
    } catch (e) {}
    return false;
  }

  Future<bool> logout() async {
    return true;
  }
}
