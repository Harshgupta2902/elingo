import 'package:flutter/material.dart';

import '../global.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.initialValue,
    this.obscureText,
    this.keyboardType,
    this.labelText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.controller,
  });
  final String? initialValue;
  final String? labelText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$labelText",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          cursorColor: GlobalColors.primaryColor,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w500, fontSize: 18),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: GlobalColors.primaryColor,
              ),
            ),
            suffixIcon: suffixIcon,
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
