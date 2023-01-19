class RaceSchedule {
  late final int? id;
  final DateTime day; // 開催日
  final String raceName; // レース名
  final String raceCourse; // 競馬場
  final String grade; // 重賞グレード

  RaceSchedule({
    this.id,
    required this.day,
    required this.raceName,
    required this.raceCourse,
    required this.grade,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'day': day,
      'raceName': raceName,
      'raceCourse': raceCourse,
      'grade': grade,
    };
  }
}
