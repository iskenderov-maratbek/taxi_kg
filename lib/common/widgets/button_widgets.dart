import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';

Widget primaryButton(
  String text, {
  double fontSize = 22,
  void Function()? onPressed,
}) =>
    ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      child: primaryText(
        text,
        fontSize: fontSize,
        color: AppColors.black,
      ),
    );

Widget secondaryButton(
  String text, {
  double fontSize = 20,
  void Function()? onPressed,
}) =>
    TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(AppColors.transparent),
      ),
      onPressed: onPressed,
      child: secondaryText(
        text,
        fontSize: fontSize,
      ),
    );

Widget buttonWithImg({
  Function()? onPressed,
  Color textColor = AppColors.white,
  Color bgColor = AppColors.black,
  required String text,
  required String imgPath,
}) =>
    ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
        side: MaterialStateProperty.all<BorderSide>(const BorderSide(color: AppColors.white)),
        backgroundColor: MaterialStateProperty.all<Color>(bgColor),
        minimumSize: MaterialStateProperty.all<Size>(const Size(50, 50)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            imgPath,
            width: 30,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.low,
          ),
          const SizedBox(width: 20),
          Expanded(child: secondaryText(text, color: textColor)),
        ],
      ),
    );
