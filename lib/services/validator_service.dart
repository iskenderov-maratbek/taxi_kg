import 'package:taxi_kg/views/misc/misc_methods.dart';
import 'package:taxi_kg/views/forms/rules.dart';

class Validators {
  static String? phoneNumber(String? value) {
    logInfo('Валидация номера: $value');
    return null;
  }

  static String? email(String? value) {
    logInfo('Валидация почты: $value');
    if (value != null) {
      for (var check in emailRules.values) {
        if (!check(value)) {
          logError('Некорректная почта: $value');
          return ' Неправильный почтовый адрес';
        }
      }
      logInfo('Почта прошла проверку успешно!: $value');
      return null;
    } else {
      return 'Заполните поле';
    }
  }

  static String? username(String? value) {
    logInfo('Валидация имени пользователя: $value');
    return null;
  }

  static String? pinCode(String? value) {
    if (value != null && value.isNotEmpty && value.length == 4) {
      if (value.length == 4) {
        return null;
      } else {
        return 'Заполните поле!';
      }
    }
    return 'Заполните поле!';
  }
}
