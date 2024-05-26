// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// void main() {
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.indigo),
//       home: const AuthWidget(),
//     );
//   }
// }

// class AuthWidget extends ConsumerWidget {
//   const AuthWidget({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authStateAsync = ref.watch(authStateChangesProvider);
//     return authStateAsync.when(
//       data: (signedIn) {
//         if (signedIn) {
//           return const SignOutScreen();
//         } else {
//           return const SignInScreen();
//         }
//       },
//       error: (e, st) => Scaffold(body: Center(child: Text(e.toString()))),
//       loading: () =>
//           const Scaffold(body: Center(child: CircularProgressIndicator())),
//     );
//   }
// }