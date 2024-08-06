import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/button_form.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';

Widget primaryButton(
  String text, {
  double fontSize = 22,
  double vertical = 16,
  required void Function() onPressed,
}) =>
    CustomButton(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: vertical),
      onTap: onPressed,
      color: AppColors.yellow,
      children: [
        primaryText(
          text,
          fontSize: fontSize,
          color: AppColors.black,
        ),
      ],
    );

Widget secondaryButton(
  String text, {
  double fontSize = 20,
  required void Function() onPressed,
}) =>
    CustomButton(
      color: AppColors.transparent,
      onTap: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      children: [
        secondaryText(
          text,
          fontSize: fontSize,
        ),
      ],
    );

Widget buttonWithImg({
  required Function() onPressed,
  Color textColor = AppColors.white,
  Color bgColor = AppColors.black,
  required String text,
  required String imgPath,
}) =>
    CustomButton(
      onTap: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      borderColor: AppColors.white,
      color: bgColor,
      children: [
        Flexible(
          flex: 3,
          child: Image.asset(
            imgPath,
            width: 30,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.low,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
            flex: 20,
            child: secondaryText(
              text,
              color: textColor,
              overflow: TextOverflow.fade,
            )),
      ],
    );

Widget alternativeSecondaryButton(
  String text, {
  double fontSize = 16,
  Color color = AppColors.blue,
  void Function()? onPressed,
}) =>
    TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(AppColors.transparent),
      ),
      onPressed: onPressed,
      child: secondaryText(
        text,
        color: color,
        fontSize: fontSize,
        maxLines: 2,
      ),
    );
