// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:taxi_kg/common/widgets/dialog_forms.dart';
// import 'package:taxi_kg/providers/providers.dart';
// import 'package:taxi_kg/services/auth_service.dart';
// import 'package:taxi_kg/views/auth/authPage/auth_view.dart';
// import 'package:taxi_kg/views/auth/pinCodeViews/pin_code_email.dart';
// import 'package:taxi_kg/views/auth/register_view.dart';
// import 'package:taxi_kg/views/home/home.dart';

// class MainView extends ConsumerStatefulWidget {
//   const MainView({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
// }

// class _MainViewState extends ConsumerState<MainView> {
//   // authStateController(AuthState state) {
//   //   return switch (state) {
//   //     AuthState.loading => Dialogs.loadingWithText(
//   //         text: 'Загрузка...',
//   //       ),
//   //     AuthState.notFound => Dialogs.informationState(
//   //         'Аккаунт не найден',
//   //         context: context,
//   //         seconds: 3,
//   //       ),
//   //     AuthState.error => Dialogs.informationState(
//   //         'Непредвиденная ошибка',
//   //         context: context,
//   //         seconds: 3,
//   //       ),
//   //     AuthState.sendCodeEmail => Navigator.pushNamed(context, '/pincode-email'),
//   //     AuthState.success => Navigator.pushNamed(context, '/home'),
//   //     AuthState.auth => Navigator.pushNamed(context, '/auth'),
//   //     AuthState.register => Navigator.pushNamed(context, '/register'),
//   //   };
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var authState = ref.watch(authStateChangesProvider);
//     return Stack(
//       children: [
//         const AuthView(),
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 400),
//           transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
//           child: authState.when(
//             data: (state) {
//               return switch (state) {
//                 AuthState.loading => Dialogs.loadingWithText(
//                     text: 'Загрузка...',
//                   ),
//                 AuthState.notFound => Dialogs.informationState(
//                     'Аккаунт не найден',
//                     context: context,
//                     seconds: 3,
//                   ),
//                 AuthState.error => Dialogs.informationState(
//                     'Непредвиденная ошибка',
//                     context: context,
//                     seconds: 3,
//                   ),
//                 AuthState.sendCodeEmail => const PinCodeEmail(email: '',),
//               };
//             },
//             error: (error, sttr) => Container(),
//             loading: () => const CircularProgressIndicator(),
//           ),
//         ),
//       ],
//     );
//   }
// }
