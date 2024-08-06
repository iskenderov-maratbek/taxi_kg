import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/button_widgets.dart';
import 'package:taxi_kg/common/widgets/loading_indicator.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';

class Dialogs {
  static Widget informationState(String text,
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

  static Future<bool?> confirmForm(context) => showDialog<bool>(
        context: context,
        builder: (BuildContext context) => getDialogForm(
          canPop: true,
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
                    child: primaryButton('Да',
                        onPressed: () => Navigator.pop(context, true), vertical: 10),
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

  static Widget loadingWithText({
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

  static Widget getDialogForm(child, {EdgeInsets insetPadding = EdgeInsets.zero, canPop = false}) =>
      PopScope(
        canPop: canPop,
        onPopInvoked: (popp) {},
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            backgroundColor: AppColors.transparent,
            insetPadding: insetPadding,
            actionsPadding: EdgeInsets.zero,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(.2),
                    spreadRadius: 10,
                    blurRadius: 20,
                  ),
                ]),
                child: child,
              ),
            ],
          ),
        ),
      );

  static Widget interactiveInformationState(
    String title, {
    Icon? icon,
    Widget content = const Text('asdasd'),
    required BuildContext context,
    int seconds = 20,
  }) =>
      getDialogForm(
        Column(
          children: [
            Wrap(
              children: [
                if (icon != null) icon,
                primaryText(title),
              ],
            ),
            content,
          ],
        ),
      );
}
