import 'dart:ffi';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/dialog_forms.dart';
import 'package:taxi_kg/common/widgets/snackbar_form.dart';
import 'package:taxi_kg/common/widgets/text_field_widgets.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/providers/providers.dart';
import 'package:taxi_kg/views/auth/pinCodeViews/pin_code_email.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';
import 'package:taxi_kg/common/widgets/segmented_form.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final _numberKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'iskenderov.maratbek@gmail.com');
  final _numberController = TextEditingController();
  
  late Map<int, String> tabItems;
  late List<Widget> items;
  int _segmentedIndex = 0;
  bool closeApp = false;
  @override
  void initState() {
    tabItems = {
      0: 'Почта',
      1: 'Номер',
    };
    items = [
      Form(key: _emailKey, child: emailTextField(_emailController)),
      Form(key: _numberKey, child: numberTextField(_numberController)),
    ];
    super.initState();
  }

  @override
  void dispose() {
    logDispose('Страница Auth');
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  _selectedIndex(int index) {
    logInfo('SEGMENTED INDEX: $index');
    _segmentedIndex = index;
  }

  login() async {
    logInfo('Выбранное меню: $_segmentedIndex');
    switch (_segmentedIndex) {
      case 0:
        if (_emailKey.currentState!.validate()) {
          ref.read(authMethodChangeProvider).sta
          showPinCodeEmail(context, email: _emailController.text);
        }
      case 1:
        if (_numberKey.currentState!.validate()) {
          // Navigator.push(
          //   context,
          //   CustomRoute(
          //       builder: (BuildContext context) =>
          //           PinCodeView(userdata: _emailController.text, isNumber: true)),
          // );
        }
    }
  }

  onPopInvoked(pop) {
    if (closeApp) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        snackbarForm('Вы вышли из приложения'),
      );
    } else {
      setState(() {
        closeApp = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        snackbarForm('Нажмите ещё раз чтобы закрыть приложение'),
      );
      Future.delayed(const Duration(seconds: 2), () {
        closeApp = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    logBuild('Auth');
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: onPopInvoked,
        child: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      primaryText('Вход'),
                      const SizedBox(height: 20),
                      SegmentedForm(
                        sizedBox: 5,
                        tabItems: tabItems,
                        items: items,
                        selectedIndex: _selectedIndex,
                      ),
                      const SizedBox(height: 15),
                      primaryButton('Войти', onPressed: login),
                      const SizedBox(height: 20),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          buttonWithImg(
                              text: 'Продолжить с Apple',
                              imgPath: 'assets/images/icons/apple_auth.png',
                              onPressed: () {}),
                          const SizedBox(height: 10),
                          buttonWithImg(
                              text: 'Продолжить с Google',
                              imgPath: 'assets/images/icons/google_auth.png',
                              bgColor: AppColors.white,
                              textColor: AppColors.black,
                              onPressed: () {}),
                        ],
                      ),
                      const SizedBox(height: 15),
                      const Divider(indent: 15, endIndent: 15, color: AppColors.secondaryWhite),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          secondaryText('Нет аккаунта?', color: AppColors.white),
                          secondaryButton(
                            'Регистрация',
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Navigator.pushNamed(context, '/register');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
