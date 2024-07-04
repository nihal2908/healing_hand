import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool? obscured;
  final TextInputType? keyboard;
  final int? maxlines;

  CustomTextFormField({
    required this.labelText,
    required this.controller,
    required this.validator,
    this.obscured,
    this.keyboard,
    this.maxlines
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscured ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      keyboardType: keyboard ?? TextInputType.text,
      maxLines: maxlines==null ? maxlines : 1,
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  CustomPasswordField({
    required this.labelText,
    required this.controller,
    required this.validator,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscured = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscured,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: Colors.grey.shade100,
        suffix: IconButton(
          onPressed: (){
            setState(() {
              obscured = false;
            });
          },
          icon: obscured ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
    );;
  }
}
