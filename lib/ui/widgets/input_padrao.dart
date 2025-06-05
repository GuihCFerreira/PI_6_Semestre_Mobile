import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iplay/core/functions/theme_colors.dart';

class InputPadrao extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final int? maxLength;
  final TextInputType keyboardType;
  final bool buildCounter;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final double prefixIconSize;
  final String? prefixText;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;
  final String? hintText;
  final EdgeInsetsGeometry contentPadding;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int maxLines;
  final Function(String)? onChanged;
  final BoxConstraints? constraints;
  final double fontSize;
  const InputPadrao({
    super.key,
    required this.controller,
    required this.label,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.buildCounter = false,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.prefixText,
    this.suffixIcon,
    this.hintText,
    this.inputFormatters,
    this.onChanged,
    this.constraints,
    this.prefixIconSize = 24,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    this.enabled = true,
    this.maxLines = 1,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLength: maxLength,
      buildCounter: (BuildContext context, {required int currentLength, required bool isFocused, required int? maxLength}) => buildCounter
          ? Text(
              '$currentLength/$maxLength',
              style: TextStyle(
                color: enabled ? ThemeColors.primary : Colors.grey,
              ),
            )
          : null,
      style: TextStyle(
        color: enabled ? ThemeColors.primary : Colors.grey,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ),
      maxLines: maxLines,
      onChanged: onChanged,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        constraints: constraints,
        prefixText: prefixText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: enabled ? ThemeColors.primary : Colors.grey, size: prefixIconSize) : null,
        suffixIcon: suffixIcon,
        alignLabelWithHint: true,
        labelText: label,
        floatingLabelStyle: TextStyle(color: enabled ? ThemeColors.primary : Colors.grey, fontSize: 16),
        hintText: hintText,
        hintStyle: TextStyle(color: enabled ? ThemeColors.primary : Colors.grey, fontSize: fontSize),
        filled: true,
        contentPadding: contentPadding,
        fillColor: Colors.white,
        labelStyle: TextStyle(
          color: enabled ? ThemeColors.primary : Colors.grey,
          fontSize: fontSize,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.primary, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: ThemeColors.primary),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
