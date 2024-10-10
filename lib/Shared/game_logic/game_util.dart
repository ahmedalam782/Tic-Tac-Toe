import 'dart:math';

import 'package:flutter/widgets.dart';

GlobalKey<FormState> form = GlobalKey();
TextEditingController playerXController = TextEditingController();
TextEditingController playerOController = TextEditingController();

List<String> board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
Map<String, int> scores = {'X': -1, 'O': 1, 'DRAW': 0};
bool xTurn = true;
bool computerTurn = false;
int playerXScore = 0;
int playerOScore = 0;
int filledBoxes = 0;
bool isPlaySound=false;

void resetGame() {
  board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
  xTurn = true;
  computerTurn = false;
  filledBoxes = 0;
}

bool playing = true;

String winner(int index) {
  if (board[index] == 'X') {
    return 'X';
  } else {
    return 'O';
  }
}

void endGame(bool stopGame) {
  if (stopGame) {
    playing = false;
  }
}

String checkDraw(bool stopGame) {
  bool boardFull = true;

  for (int i = 0; i < board.length; i++) {
    if (board[i] == ' ') {
      boardFull = false;
    }
  }

  if (boardFull) {
    if (stopGame) {
      playing = false;
    }
    return 'DRAW';
  } else {
    return ' ';
  }
}

bool checkWinner(String win) {
  if (board[0] == win && board[1] == win && board[2] == win) {
    return true;
  }

  if (board[3] == win && board[4] == win && board[5] == win) {
    return true;
  }

  if (board[6] == win && board[7] == win && board[8] == win) {
    return true;
  }

  if (board[0] == win && board[3] == win && board[6] == win) {
    return true;
  }

  if (board[1] == win && board[4] == win && board[7] == win) {
    return true;
  }

  if (board[2] == win && board[5] == win && board[8] == win) {
    return true;
  }

  if (board[0] == win && board[4] == win && board[8] == win) {
    return true;
  }

  if (board[2] == win && board[4] == win && board[6] == win) {
    return true;
  }

  return false;
}

String checkWinnerToMinMax(bool stopGame) {
  if (board[0] == board[1] && board[1] == board[2] && board[2] != ' ') {
    return winner(0);
  }

  if (board[3] == board[4] && board[4] == board[5] && board[5] != ' ') {
    return winner(3);
  }

  if (board[6] == board[7] && board[7] == board[8] && board[8] != ' ') {
    return winner(6);
  }

  if (board[0] == board[3] && board[3] == board[6] && board[6] != ' ') {
    return winner(0);
  }

  if (board[1] == board[4] && board[4] == board[7] && board[7] != ' ') {
    return winner(1);
  }

  if (board[2] == board[5] && board[5] == board[8] && board[8] != ' ') {
    return winner(2);
  }

  if (board[0] == board[4] && board[4] == board[8] && board[8] != ' ') {
    return winner(0);
  }

  if (board[2] == board[4] && board[4] == board[6] && board[6] != ' ') {
    return winner(2);
  }

  return checkDraw(stopGame);
}

void tap(String symbol, int index) {
  if (board[index] == ' ') {
    board[index] = symbol;
    xTurn = !xTurn;
    filledBoxes++;
  }
}

void play(int index, bool computerPlaying) {
  if (computerPlaying) {
    if (xTurn) {
      tap('X', index);
    }
  } else {
    if (xTurn) {
      tap('X', index);
    } else {
      tap('O', index);
    }
  }
}

int randomPlay() {
  int random;

  do {
    random = Random().nextInt(board.length);
  } while (board[random] != ' ');

  return random;
}

int minimax(List<String> gameBoard, int depth, bool isMaximizing,
    bool mediumDifficulty) {
  String result = checkWinnerToMinMax(false);
  if (result != ' ') {
    return scores[result]!;
  }

  if (isMaximizing) {
    int bestScore = -2;
    for (int i = 0; i < gameBoard.length; i++) {
      if (gameBoard[i] == ' ') {
        gameBoard[i] = 'O';
        int score =
            minimax(gameBoard, depth + 1, mediumDifficulty, mediumDifficulty);
        gameBoard[i] = ' ';
        bestScore = max(score, bestScore);
      }
    }
    return bestScore;
  } else {
    int bestScore = 2;
    for (int i = 0; i < gameBoard.length; i++) {
      if (gameBoard[i] == ' ') {
        gameBoard[i] = 'X';
        int score = minimax(gameBoard, depth + 1, true, mediumDifficulty);
        gameBoard[i] = ' ';
        bestScore = min(score, bestScore);
      }
    }
    return bestScore;
  }
}

int nextPlay(bool mediumDifficulty) {
  int bestScore = -2;
  int bestPossiblePlay = -1;
  for (int i = 0; i < board.length; i++) {
    if (board[i] == ' ') {
      board[i] = 'O';
      int score = minimax(board, 0, false, mediumDifficulty);
      board[i] = ' ';
      if (score > bestScore) {
        bestScore = score;
        bestPossiblePlay = i;
      }
    }
  }
  return bestPossiblePlay;
}

void computerPlay(String difficulty) {
  if (!xTurn) {
    if (difficulty == 'EASY') {
      tap('O', randomPlay());
    }

    if (difficulty == 'MEDIUM') {
      tap('O', nextPlay(true));
    }

    if (difficulty == 'HARD') {
      tap('O', nextPlay(false));
    }
  }
}
