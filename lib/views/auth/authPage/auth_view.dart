import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/text_field_widgets.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/views/auth/pinCodeDialog/pin_code_view.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';
import 'package:taxi_kg/views/view_builder.dart';
import 'package:taxi_kg/common/widgets/segmented_form.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  final _numberKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'marat@gmail.com');
  final _numberController = TextEditingController(text: '');
  late Map<int, String> tabItems;
  late List<Widget> items;
  int _segmentedIndex = 0;

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
        _emailKey.currentState!.validate()
            ? showPinCodeDialog(context, _emailController.text, isNumber: true)
            : null;
      case 1:
        _numberKey.currentState!.validate()
            ? showPinCodeDialog(context, _numberController.text)
            : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    logBuild('Auth');
    return PageBuilder(
      canPop: false,
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
                  text: 'Продолжить с Apple', imgPath: 'assets/images/icons/apple_auth.png'),
              const SizedBox(height: 10),
              buttonWithImg(
                  text: 'Продолжить с Google',
                  imgPath: 'assets/images/icons/google_auth.png',
                  bgColor: AppColors.white,
                  textColor: AppColors.black),
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
    );
  }
}
