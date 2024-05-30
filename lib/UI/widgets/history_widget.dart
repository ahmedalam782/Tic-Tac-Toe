import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../Shared/themes/color.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.historyGame,
  });

  final Map historyGame;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.kWhitish,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 2.1.w,
              height: 8.h,
              decoration: const BoxDecoration(
                color: MyColor.kWhitish,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('MMM d, y HH:mm')
                          .format(historyGame['date'].date.toLocal()),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Material(
                            elevation: 5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                                child: Text(
                              historyGame['player_x_score'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          historyGame['player_x_name'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: MyColor.kBlue,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "VS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          historyGame['player_o_name'],
                          style: const TextStyle(
                            color: MyColor.kPurple,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Material(
                            elevation: 5,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                                child: Text(
                              historyGame['player_o_score'],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Draw',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: MyColor.kBlue,
                      ),
                    ),
                    SizedBox(
                      height: 2.w,
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Material(
                        elevation: 5,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                            child: Text(
                          historyGame['draw_score'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
