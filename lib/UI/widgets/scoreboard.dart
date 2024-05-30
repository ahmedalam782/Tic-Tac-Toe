import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../Shared/themes/color.dart';


class ScoreBoard extends StatelessWidget {
  final int playerScore;
  final bool isTurn;
  final bool isPlayerTurn;
  final String playerName;

  const ScoreBoard({
    super.key,
    required this.playerScore,
    required this.isTurn,
    required this.playerName,
    required this.isPlayerTurn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0.w),
      margin: EdgeInsets.all(2.h),
      decoration: BoxDecoration(
        color: MyColor.kForeground,
        borderRadius: BorderRadius.circular(3.0.w),
        border: isPlayerTurn
            ? isTurn
                ? Border.all(
                    color: MyColor.kBlue,
                    width: 2.0,
                  )
                : Border.all(
                    color: MyColor.kPurple,
                    width: 2.0,
                  )
            : Border.all(
                color: MyColor.kWhitish,
                width: 2.0,
              ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Material(
              elevation: 5,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: Center(
                  child: Text(
                playerScore.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              playerName,
              style: TextStyle(
                fontSize: 20.sp,
                color: isTurn ? MyColor.kBlue : MyColor.kPurple,
              ),
            ),
          ),
          Text(
            isTurn ? 'X' : 'O',
            style: TextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: isTurn ? MyColor.kBlue : MyColor.kPurple,
            ),
          ),
        ],
      ),
    );
  }
}
