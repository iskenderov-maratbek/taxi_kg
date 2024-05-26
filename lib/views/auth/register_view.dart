import 'package:flutter/material.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/text_field_widgets.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/common/widgets/segmented_form.dart';
import 'package:taxi_kg/views/auth/pinCodeDialog/pin_code_view.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';
import 'package:taxi_kg/views/view_builder.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _numberKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  late Map<int, String> tabItems;
  late List<Widget> items;
  int _segmentedIndex = 0;
  @override
  void initState() {
    tabItems = {0: 'Почта', 1: 'Номер'};
    items = [
      Form(key: _emailKey, child: emailTextField(_emailController)),
      Form(key: _numberKey, child: numberTextField(_numberController))
    ];
    super.initState();
  }

  void _selectedIndex(int? index) {
    _segmentedIndex = index ?? 0;
  }

  @override
  void dispose() {
    logDispose('Register');
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  register() async {
    logInfo('Выбранное меню: $_segmentedIndex');
    switch (_segmentedIndex) {
      case 0:
        _emailKey.currentState!.validate()
            ? showPinCodeDialog(context, _emailController.text)
            : null;
      case 1:
        _numberKey.currentState!.validate()
            ? showPinCodeDialog(context, _numberController.text)
            : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    logBuild('Regsiter');
    return PageBuilder(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          primaryText('Регистрация'),
          const SizedBox(height: 20),
          SegmentedForm(
              sizedBox: 5, tabItems: tabItems, items: items, selectedIndex: _selectedIndex),
          const SizedBox(height: 10),
          usernameTextField(_usernameController),
          const SizedBox(height: 20),
          primaryButton(
            'Далее',
            onPressed: register,
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              secondaryText('Уже есть аккаунт?', color: AppColors.white),
              secondaryButton(
                'Войти',
                onPressed: () => Navigator.pop(context, '/auth'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
