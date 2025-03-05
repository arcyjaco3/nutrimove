class TaskModel {
  final String title;
  final String? note;
  final DateTime date;
  final String startTime;
  final String endTime;
  final int remind;
  final String repeat;
  final int color;

   TaskModel({
    required this.title,
    this.note,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.repeat,
    required this.color,
  });


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'note': note,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'remind': remind,
      'repeat': repeat,
      'color': color,
      'createdAt': DateTime.now(),
    };
  }
}