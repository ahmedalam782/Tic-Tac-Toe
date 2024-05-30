import 'package:flutter/material.dart';

import '../../Shared/components/button_widget.dart';
import '../../Shared/game_logic/game_util.dart';
import '../../Shared/services/sound.dart';
import '../../Shared/themes/color.dart';

void showGameAlertDialog({
  required String message,
  required BuildContext context,
  required String winner,
}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: MyColor.kLighterForeground,
          elevation: 0,
          title: const Text(
            "Game Over",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          actions: [
            ButtonWidget(
              onPressed: () {
                if (isPlaySound) {
                  SoundService(sound: 'sounds/click.mp3').playSound();
                }

                Navigator.of(context).pop();
              },
              winner: winner,
              text: 'Play Again',
            ),
          ],
        );
      });
}
