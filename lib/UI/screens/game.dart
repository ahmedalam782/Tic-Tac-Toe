import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../Shared/components/wrapper_container.dart';

import '../../Shared/game_logic/game_util.dart';
import '../../Shared/services/sound.dart';
import '../widgets/board.dart';
import '../widgets/dialog_border.dart';
import '../widgets/scoreboard.dart';

class GamePage extends StatefulWidget {
  final String playerXName;
  final String playerOName;
  final bool isAgainstAI;
  final String levelsAI;

  const GamePage({
    super.key,
    required this.playerXName,
    required this.playerOName,
    required this.isAgainstAI,
    required this.levelsAI,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: WrapperContainer(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ScoreBoard(
                    playerScore: playerXScore,
                    isTurn: true,
                    playerName: widget.playerXName,
                    isPlayerTurn: !xTurn,
                  ),
                  Board(
                    onTap: onClickUser,
                  ),
                  ScoreBoard(
                    playerScore: playerOScore,
                    isTurn: false,
                    playerName: widget.playerOName,
                    isPlayerTurn: xTurn,
                  ),
                  Padding(
                    padding: EdgeInsets.all(1.h),
                    child: IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        if (isPlaySound) {
                          SoundService(sound: 'sounds/click.mp3').playSound();
                        }
                        resetGame();
                        playerXController.text = '';
                        playerOController.text = '';
                        playerXScore = 0;
                        playerOScore = 0;
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      color: Colors.white,
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  onClickUser(int position) {
    String opponent = widget.isAgainstAI ? 'COMPUTER' : 'O';
    String player = widget.isAgainstAI ? 'YOU' : 'X';
    String verbWin = player == 'YOU' ? 'WIN' : 'WINS';
    if (widget.isAgainstAI) {
      setState(() {
        if (!computerTurn) {
          play(position, widget.isAgainstAI);
          if (isPlaySound) {
            SoundService(sound: 'sounds/x.mp3').playSound();
          }
        }
      });
      computerTurn = true;
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (isPlaySound) {
            SoundService(sound: 'sounds/o.mp3').playSound();
          }
          computerPlay(widget.levelsAI);
          checkWinnerToMinMax(true);
          computerTurn = false;
          if (checkWinner("O")) {
            playerOScore++;
            showGameAlertDialog(
              context: context,
              message: '$opponent WINS!',
              winner: 'O',
            );
            resetGame();
          }
        });
      });
    } else {
      setState(() {
        play(position, widget.isAgainstAI);
        if (isPlaySound && board[position] == 'O') {
          SoundService(sound: 'sounds/o.mp3').playSound();
        } else if (isPlaySound && board[position] == 'X') {
          SoundService(sound: 'sounds/x.mp3').playSound();
        }
      });
    }

    if (checkWinner('X')) {
      playerXScore++;
      showGameAlertDialog(
        context: context,
        message: '$player $verbWin!',
        winner: 'X',
      );
      resetGame();
    } else if (opponent != 'COMPUTER') {
      if (checkWinner("O")) {
        playerOScore++;
        showGameAlertDialog(
          context: context,
          message: '$opponent WINS!',
          winner: 'O',
        );
        resetGame();
      }
    }
    if (filledBoxes == 9) {
      showGameAlertDialog(
        context: context,
        message: 'DRAW!',
        winner: '',
      );
      resetGame();
    }
    setState(() {});
  }
}
