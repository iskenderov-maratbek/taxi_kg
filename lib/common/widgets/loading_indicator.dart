import 'package:flutter/material.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';

Widget laodingIndicator() => const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 8,
          color: AppColors.yellow,
        ),
        SizedBox(height: 15),
      ],
    );
