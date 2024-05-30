import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


import '../../Shared/game_logic/game_util.dart';
import '../../Shared/themes/color.dart';

class Board extends StatelessWidget {
  final Function onTap;

  const Board({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: GridView.builder(
        padding: EdgeInsets.all(3.h),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 1.w, horizontal: 1.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  board[index],
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color:
                        board[index] == 'X' ? MyColor.kBlue : MyColor.kPurple,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: board.length,
      ),
    );
  }
}
