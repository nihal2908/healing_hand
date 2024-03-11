import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.validator,
    this.readOnly,
    this.keyboardType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      keyboardType: keyboardType ?? TextInputType.text,
      readOnly: readOnly ?? false,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText,
        icon: Icon(icon),
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.center,
      ),
      validator: validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}
