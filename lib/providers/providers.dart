import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/services/auth_service.dart';
import 'package:taxi_kg/services/restrictions_service.dart';

final authServiceProvider = Provider.autoDispose<AuthService>((ref) {
  final auth = AuthService();
  ref.onDispose(() => auth.dispose());
  return auth;
}, name: 'Сервис авторизации');

final authStateChangesProvider = StreamProvider.autoDispose<AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges();
}, name: 'Состояние сервиса авторизации');

final timerStateChangesProvider = StreamProvider.autoDispose<TimerState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.timerStateChanges();
}, name: 'Состояние таймера авторизации');

final _authMethodStateProvider = NotifierProvider<AuthMethodState, AuthMethod>(
  () => AuthMethodState(),
);
// enum PinCodeState {
//   sendCode,
//   success,
//   error,
// }
final restrictionsServiceProvider = Provider.autoDispose<RestrictionsService>((ref) {
  final restrictions = RestrictionsService();
  // ref.onDispose(() => auth.dispose());
  return restrictions;
}, name: 'Сервис ограничений');

// final pinCodeProvider = StreamProvider.autoDispose<AuthState>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return authRepository.authStateChanges();
// },name: 'Состояние авторизации');

class AuthMethodState extends Notifier<AuthMethod> {
  @override
  AuthMethod build() {
    return AuthMethod.none;
  }
}
