import 'package:flutter/material.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/common/widgets/loading_indicator.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';

Widget informationState(String text,
    {Icon? icon, bool isLogin = false, required BuildContext context, int seconds = 20}) {
  Future.delayed(Duration(seconds: seconds), () {
    Navigator.pop(context, isLogin);
  });
  return getDialogForm(
    Column(
      children: [
        if (icon != null) icon,
        primaryText(text),
      ],
    ),
  );
}

Future<bool?> confirmForm(context) => showDialog<bool>(
      context: context,
      builder: (BuildContext context) => getDialogForm(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            primaryText('Вы уверены, что хотите отменить?', fontSize: 18),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: primaryButton('Да', onPressed: () => Navigator.pop(context, true)),
                ),
                Expanded(
                  child: secondaryButton('Нет', onPressed: () => Navigator.pop(context, false)),
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget loadingWithText({
  String? text,
}) {
  return getDialogForm(
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        laodingIndicator(),
        primaryText(text ?? 'загрузка...', fontSize: text != null ? 20 : 18),
      ],
    ),
  );
}

getDialogForm(child) => AlertDialog(
      backgroundColor: AppColors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
      actionsPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: AppColors.bgDialog,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: AppColors.yellow),
          ),
          child: child,
        )
      ],
    );
