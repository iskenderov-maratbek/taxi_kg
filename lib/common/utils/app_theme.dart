import 'package:flutter/material.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/views/misc/custom_input_border.dart';
import 'package:taxi_kg/views/misc/custom_transition.dart';

class AppTheme {
  static ThemeData appThemeData() => ThemeData(
        fontFamily: 'MiSans',
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CustomTransition(),
            TargetPlatform.iOS: CustomTransition(),
            TargetPlatform.macOS: CustomTransition(),
            TargetPlatform.windows: CustomTransition(),
          },
        ),
        appBarTheme: const AppBarTheme(backgroundColor: AppColors.transparent),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.transparent),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.yellow,
          selectionColor: Colors.blue,
          selectionHandleColor: AppColors.yellow,
        ),
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(18),
          prefixStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIconColor: Colors.white,
          filled: true,
          fillColor: Colors.grey[900],
          enabledBorder: CustomInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          border: CustomInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: CustomInputBorder(
            borderSide: BorderSide(color: Colors.yellow[700]!, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: CustomInputBorder(
            borderSide: BorderSide(color: Colors.red[700]!, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: CustomInputBorder(
            borderSide: BorderSide(color: Colors.red[700]!, width: 3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(50, 70),
            backgroundColor: Colors.yellow[700],
            foregroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            iconColor:
                MaterialStateProperty.all<Color>(const Color(0xFFFBC02D)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFFFBC02D)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.resolveWith((Set<MaterialState> state) {
              if (state.contains(MaterialState.pressed)) {
                return Colors.grey[700];
              } else if (state.contains(MaterialState.selected)) {
                return Colors.black;
              }
              return Colors.black;
            }),
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          labelSmall: TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
}
