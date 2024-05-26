import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_kg/services/validator_service.dart';
import 'package:taxi_kg/common/widgets/text_field_form.dart';

emailTextField(controller) => TextFieldForm(
      maxLength: 320,
      prefixIcon: Icons.email_rounded,
      hintText: 'example@example.com',
      keyboardType: TextInputType.emailAddress,
      validator: Validators.email,
      controller: controller,
    );

numberTextField(controller) => TextFieldForm(
      maxLength: 10,
      prefixIcon: Icons.dialpad_rounded,
      hintText: '0553998299',
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: Validators.phoneNumber,
      controller: controller,
    );

usernameTextField(controller) => TextFieldForm(
      validator: Validators.username,
      controller: controller,
      prefixIcon: Icons.person_rounded,
      maxLength: 32,
      hintText: 'Как к вам обращаться?',
      keyboardType: TextInputType.name,
    );
