class CsvFormat {
  late int id;
  late String name;
  late int score;
  late int time;
  late int difficulty;

  CsvFormat(this.id, this.name, this.score, this.time, this.difficulty);
  @override
  String toString() {
    return '$id,$name,$score,$time,$difficulty';
  }
}
