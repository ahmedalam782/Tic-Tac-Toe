import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../themes/color.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      this.isEnabled = true,
      this.winner = "draw"});

  final void Function() onPressed;
  final String text;
  final String? winner;
  final bool isEnabled;

  Color getColor(bool isEnabled, String winner) {
    final colorMap = {
      false: MyColor.kGrey,
      'X': MyColor.kBlue,
      'O': MyColor.kPurple,
    };

    return isEnabled ? colorMap[winner] ?? MyColor.kForeground : MyColor.kGrey;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        isEnabled ? onPressed() : null;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: getColor(isEnabled, winner!),
        padding: EdgeInsets.symmetric(
          vertical: 2.h,
          horizontal: 5.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.w),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isEnabled ? MyColor.kWhitish : Colors.black,
        ),
      ),
    );
  }
}
