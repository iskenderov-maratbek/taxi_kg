import 'package:flutter/material.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';
import 'package:taxi_kg/common/widgets/text_widgets.dart';

snackbarForm(text) => SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: AppColors.transparent,
      content: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: AppColors.secondaryGrey,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: secondaryText(
          text,
          fontSize: 16,
          maxLines: 2,
        ),
      ),
    );
