import 'package:bank_sat/shared/theme.dart';
import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final String? label, initialValue, hints;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final void Function(String)? onChanged, onEditingComplete;

  const InputForm({
    super.key,
    this.label,
    this.obscureText = false,
    this.initialValue,
    this.onChanged,
    this.onEditingComplete,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.hints,
  });

  @override
  Widget build(BuildContext context) {
    bool hasLabel = label?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasLabel)
          Text(
            label!,
            style: blackTextStyle.copyWith(
              fontWeight: medium,
              fontSize: 14,
            ),
          ),
        if (hasLabel)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          maxLength: maxLength,
          keyboardType: keyboardType,
          controller: controller,
          initialValue: initialValue,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hints,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}
