import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authProvider = Provider<AuthService>((ref) => AuthService());

class AuthService {
  loginWithEmailAndPassword(String email, String password) {}

  logout(String email, String password) {}
}

class SomeClass extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authService.loginWithEmailAndPassword(
            '<EMAIL>',
            'password',
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
