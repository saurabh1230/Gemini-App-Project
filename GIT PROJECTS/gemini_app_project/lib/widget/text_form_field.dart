import 'package:flutter/material.dart';
import 'package:gemini_app_project/core/constants/colors.dart';

class AppFormField extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final Function()? onTap;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const AppFormField({
    super.key,
    this.hint,
    this.controller,
    this.onTap,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        
        fillColor: Theme.of(context).brightness == Brightness.dark
            ? menuTextColor3
            : whiteGrey,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade400,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        errorStyle: const TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      ),
    );
  }
}
