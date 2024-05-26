import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/views/misc/misc_methods.dart';

class PinCodeForm extends StatelessWidget {
  PinCodeForm({super.key, required this.validator, required this.controller});

  final String? Function(String?) validator;
  final TextEditingController controller;

  final double borderWidth = 2;

  final cursor = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 50,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ],
  );

  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 50,
        height: 3,
        decoration: BoxDecoration(
          color: AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ],
  );
  final defaultPinTheme = const PinTheme(
    width: 50,
    height: 80,
    textStyle: TextStyle(
      fontSize: 30,
      color: AppColors.white,
    ),
  );
  // late final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(
  //     color: AppColors.yellow,
  //     width: borderWidth,
  //   ),
  // );

  // late final errorPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(
  //     color: const Color.fromRGBO(244, 67, 54, 1),
  //     width: borderWidth,
  //   ),
  // );

  // late final submittedPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(
  //     color: const Color(0xFFFBC02D),
  //     width: borderWidth,
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    logBuild('Форма пин-кода');
    return Pinput(
      validator: validator,
      autofocus: true,
      controller: controller,
      preFilledWidget: preFilledWidget,
      length: 4,
      showCursor: true,
      cursor: cursor,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      pinAnimationType: PinAnimationType.fade,
      // separatorBuilder: (c) {
      //   return const SizedBox(width: 10);
      // },
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.none,
      mainAxisAlignment: MainAxisAlignment.center,
      defaultPinTheme: defaultPinTheme,
      closeKeyboardWhenCompleted: false,
    );
  }
}
