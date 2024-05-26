import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/common/widgets/dialog_forms.dart';
import 'package:taxi_kg/common/widgets/loading_indicator.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';
import 'package:taxi_kg/providers/providers.dart';
import 'package:taxi_kg/services/auth_service.dart';
import 'package:taxi_kg/services/validator_service.dart';
import 'package:taxi_kg/views/forms/pin_code_form.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

showPinCodeDialog(context, String userdata, {isNumber = false}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PinCodeDialog(userdata: userdata, isNumber: isNumber);
    },
  );
}

class PinCodeDialog extends ConsumerStatefulWidget {
  final String userdata;

  final bool isNumber;
  const PinCodeDialog({
    super.key,
    required this.userdata,
    required this.isNumber,
  });

  @override
  ConsumerState<PinCodeDialog> createState() => _PinCodeDialogState();
}

class _PinCodeDialogState extends ConsumerState<PinCodeDialog> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _pinCodeController = TextEditingController();
  @override
  void initState() {
    widget.isNumber
        ? ref.read(authRepositoryProvider).sendCode(number: widget.userdata)
        : ref.read(authRepositoryProvider).sendVerifyLink();
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
    logBuild('ЭКРАН ПИНКОДА');
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: authState.when(
        data: (data) => switch (data) {
          AuthState.loading => loadingWithText(),
          AuthState.notFound => informationState('Пользователь не найден', context: context),
          AuthState.success => informationState('Вы успешно авторизировались',
              context: context, seconds: 10, isLogin: true),
          AuthState.error => informationState('Ошибка сервера', context: context),
          AuthState.errorNotRecognized =>
            informationState('Непредвиденная ошибка, попробуйте позже', context: context),
          AuthState.sendCode => pinCodeField(
              ref: ref, formKey: formKey, controller: _pinCodeController, context: context),
          AuthState.sendVerifyLink => sendVerifyLinkState(data, context),
        },
        error: (Object error, StackTrace stackTrace) => const Text('data'),
        loading: () => null,
      ),
    );
  }
}

Widget pinCodeField({required BuildContext context, ref, formKey, controller}) {
  return PopScope(
    canPop: false,
    onPopInvoked: (didPop) async {
      if (!didPop) {
        if (await confirmForm(context) == true && context.mounted) {
          Navigator.pop(context);
        }
      }
    },
    child: getDialogForm(
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              primaryText('Код подтверждения', fontSize: 22
                  // fontSize: 22,
                  ),
              PinCodeForm(
                validator: Validators.pinCode,
                controller: controller,
              ),
              const SizedBox(height: 15),
              primaryButton('Подтвердить', onPressed: () {}),
              const SizedBox(height: 5),
              Center(
                child: secondaryButton('Отмена', onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (await confirmForm(context) == true && context.mounted) {
                    Navigator.pop(context);
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget sendVerifyLinkState(data, context) => PopScope(
      canPop: false,
      child: GestureDetector(
        onDoubleTap: () => Navigator.pop(context, false),
        child: getDialogForm(
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              laodingIndicator(),
              primaryText('На вашу почту отправлена ссылка для подтверждения', fontSize: 18),
              const SizedBox(height: 5),
              secondaryText('Коснитесь дважды, чтобы закрыть окно',
                  fontSize: 12, color: AppColors.grey.withOpacity(0.6)),
            ],
          ),
        ),
      ),
    );
