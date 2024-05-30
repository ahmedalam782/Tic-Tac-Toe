class HistoryModel {
  final String playerXName;
  final String playerOName;
  final String playerXScore;
  final String playerOScore;
  final String drawScore;
  final String date;

  const HistoryModel({
    required this.playerXName,
    required this.playerXScore,
    required this.playerOName,
    required this.playerOScore,
    required this.drawScore,
    required this.date,
  });
}
