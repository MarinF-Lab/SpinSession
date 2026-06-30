import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: 'Telefono',
      controller: controller,
      keyboardType: TextInputType.phone,
    );
  }
}
