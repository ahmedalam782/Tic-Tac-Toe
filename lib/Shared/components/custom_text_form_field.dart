import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../themes/color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.isX,
    this.onChanged,
    required this.controller,
    this.validator,
  });

  final String hintText;
  final bool isX;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: isX ? MyColor.kWhitish : MyColor.kPurple,
      style: const TextStyle(
        color: MyColor.kGradient1,
      ),
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      maxLength: 10,
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(3.w)),
        ),
        fillColor: MyColor.kWhitish,
        hintText: hintText,
        hintStyle: const TextStyle(color: MyColor.kBackground),
        prefixIcon: Icon(
          isX ? Icons.close : Icons.circle_outlined,
          color: isX ? MyColor.kBlue : MyColor.kPurple,
        ),
      ),
    );
  }
}
