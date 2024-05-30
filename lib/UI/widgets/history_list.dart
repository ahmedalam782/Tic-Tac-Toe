import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../Shared/themes/color.dart';
import 'history_widget.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({super.key, required this.historyGame});

  final List<Map> historyGame;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: historyGame.isNotEmpty,
      builder: (context) => CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => HistoryWidget(
                  historyGame: historyGame[index],
                ),
                childCount: historyGame.length,
              ),
            ),
          ]),
      fallback: (context) => const Center(
        child: Text(
          'No game history',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: MyColor.kWhitish,
          ),
        ),
      ),
    );
  }
}
