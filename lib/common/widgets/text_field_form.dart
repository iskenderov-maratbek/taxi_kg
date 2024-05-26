import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_kg/common/utils/app_colors.dart';

class TextFieldForm extends StatelessWidget {
  final String? Function(String?) validator;
  final TextEditingController controller;
  final IconData? prefixIcon;
  final String? prefixImg;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextInputType? keyboardType;

  const TextFieldForm({
    super.key,
    required this.validator,
    required this.controller,
    this.prefixIcon,
    this.prefixImg,
    this.inputFormatters,
    this.hintText,
    this.keyboardType,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
      style: const TextStyle(
        fontSize: 18,
      ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 5),
              child: Icon(
                prefixIcon,
                color: AppColors.yellow,
                size: 25,
              ),
            ),
          ],
        ),
        errorStyle: const TextStyle(color: AppColors.error),
        errorMaxLines: 2,
        counterText: '',
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: 18,
        ),
      ),
    );
  }
}
