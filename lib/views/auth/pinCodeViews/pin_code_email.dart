import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/common/widgets/dialog_forms.dart';
import 'package:taxi_kg/common/widgets/loading_indicator.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';
import 'package:taxi_kg/common/widgets/timer_widget.dart';
import 'package:taxi_kg/providers/providers.dart';
import 'package:taxi_kg/services/auth_service.dart';
import 'package:taxi_kg/services/validator_service.dart';
import 'package:taxi_kg/views/forms/pin_code_form.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';
import 'package:taxi_kg/views/view_builder.dart';

showPinCodeEmail(BuildContext context, {required String email}) {
  showDialog(
    context: context,
    builder: (context) {
      return PinCodeEmail(email: email);
    },
  );
}

class PinCodeEmail extends ConsumerStatefulWidget {
  final String email;

  const PinCodeEmail({super.key, required this.email});

  @override
  ConsumerState<PinCodeEmail> createState() => _PinCodeDialogState();
}

class _PinCodeDialogState extends ConsumerState<PinCodeEmail> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _pinCodeController = TextEditingController();

  @override
  void initState() {
    ref.read(authServiceProvider).sendCode(email: widget.email);
    super.initState();
  }

  @override
  void dispose() {
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authState = ref.watch(authStateChangesProvider);
    var timerState = ref.watch(timerStateChangesProvider);
    logBuild('ЭКРАН ПИНКОДА');

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: authState.when(
          data: (data) => switch (data) {
                AuthState.sendCodeEmail => SafeArea(
                    child: PopScope(
                      canPop: false,
                      onPopInvoked: (didPop) async {
                        if (!didPop) {
                          if (await Dialogs.confirmForm(context) == true && context.mounted) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: GestureDetector(
                        onTap: () {
                          SystemChannels.textInput.invokeMethod('TextInput.hide');
                        },
                        child: Scaffold(
                          body: Center(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 20),
                                      primaryText('Код подтверждения', fontSize: 22
                                          // fontSize: 22,
                                          ),
                                      PinCodeForm(
                                        validator: Validators.pinCode,
                                        controller: _pinCodeController,
                                      ),
                                      timerState.when(
                                        data: (data) {
                                          switch (data) {
                                            case TimerState.run:
                                              return TimerWidget(
                                                seconds: 10,
                                                endOfTimerFunction: () {
                                                  ref.read(authServiceProvider).reSendCodeEmail();
                                                },
                                                endOfTimerText: 'Получить код ещё раз',
                                              );
                                            case TimerState.cooldown:
                                              return alternativeSecondaryButton(
                                                ' !',
                                                color: AppColors.error,
                                              );
                                            default:
                                              return const Text('Other');
                                          }
                                        },
                                        error: (error, stackTrace) =>
                                            const Text('Ошибка. Перезапустите приложение'),
                                        loading: () => laodingIndicator(),
                                      ),
                                      primaryButton('Подтвердить', onPressed: () {}),
                                      const SizedBox(height: 5),
                                      Center(
                                        child: secondaryButton('Отмена', onPressed: () async {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          if (await Dialogs.confirmForm(context) == true &&
                                              context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                AuthState.loading => Dialogs.loadingWithText(text: 'Загрузка'),
                AuthState.notFound =>
                  Dialogs.informationState('Аккаунт не найден', context: context, seconds: 3),
                AuthState.error =>
                  Dialogs.informationState('Непредвиденная ошибка', context: context, seconds: 3),
              },
          error: (Object error, StackTrace stackTrace) {
            return null;
          },
          loading: () {
            return null;
          }),
    );
    //                   ),
    //                 ),
    //               ),
    //             )
    //           : switch (data) {
    //               AuthState.loading => loadingWithText(),
    //               AuthState.notFound => informationState('Пользователь не найден', context: context),
    //               AuthState.success => informationState('Вы успешно авторизировались',
    //                   context: context, seconds: 10, isLogin: true),
    //               AuthState.error => informationState('Ошибка сервера', context: context),
    //               AuthState.invalidErrorCode =>
    //                 informationState('Непредвиденная ошибка, попробуйте позже', context: context),
    //               AuthState.sendVerifyLink => sendVerifyLinkState(data, context),
    //               AuthState.sendCode => Container(),
    //               AuthState.autoSendCooldown => throw UnimplementedError(),
    //             },
    //       error: (Object error, StackTrace stackTrace) => const Text('data'),
    //       loading: () => null,
    //     ),
    //   );
    // }
  }
}

// Widget sendVerifyLinkState(data, context) => PopScope(
//       canPop: false,
//       child: GestureDetector(
//         onDoubleTap: () => Navigator.pop(context, false),
//         child: getDialogForm(
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               laodingIndicator(),
//               primaryText('На вашу почту отправлена ссылка для подтверждения', fontSize: 18),
//               const SizedBox(height: 5),
//               secondaryText('Коснитесь дважды, чтобы закрыть окно',
//                   fontSize: 12, color: AppColors.grey.withOpacity(0.6)),
//             ],
//           ),
//         ),
//       ),
//     );