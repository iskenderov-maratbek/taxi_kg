import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/services/auth_service.dart';

final authRepositoryProvider = Provider.autoDispose<AuthService>((ref) {
  final auth = AuthService(AuthState.loading);
  ref.onDispose(() => auth.dispose());
  return auth;
}, name: 'Репозиторий авторизации');

final authStateChangesProvider = StreamProvider.autoDispose<AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}, name: 'Состояние авторизации');

// enum PinCodeState {
//   sendCode,
//   success,
//   error,
// }

// final pinCodeProvider = StreamProvider.autoDispose<AuthState>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return authRepository.authStateChanges();
// },name: 'Состояние авторизации');
