import 'package:flutter/widgets.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';

Widget primaryText(
  String text, {
  Color color = AppColors.white,
  TextOverflow? overflow,
  double? fontSize = 30,
  FontWeight? fontWeight = FontWeight.normal,
}) =>
    Text(
      text,
      overflow: overflow,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );

Widget secondaryText(
  String text, {
  Color color = AppColors.yellow,
  TextOverflow? overflow = TextOverflow.ellipsis,
  double? fontSize = 20,
  FontWeight? fontWeight = FontWeight.normal,
}) =>
    Text(
      text,
      overflow: overflow,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
