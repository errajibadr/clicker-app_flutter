class Result extends Comparable {
  // this is my update
  final String playerName;
  int _score;
  bool _isRunningScore = false;

  int get score => _score;
  bool get isRunningScore => _isRunningScore;

  Result({required this.playerName, score = 0})
      : _score = score,
        super();

  startGame() {
    _isRunningScore = true;
    _score = 0;
  }

  scoredPoint() {
    if (_isRunningScore) _score++;
  }

  endGame() {
    _isRunningScore = false;
  }

  @override
  int compareTo(other) {
    return score > other.score ? 1 : -1;
  }
}
