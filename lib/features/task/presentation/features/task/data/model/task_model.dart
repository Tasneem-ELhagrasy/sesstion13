class TaskModel {
  final int? id;
  final String title;
  final String note;
  final String starttime;
  final String endtime;
  final String date;
  final int isCompleted;
  final int color;

  TaskModel({
    required this.date,
    required this.color,
    this.id,
    required this.title,
    required this.note,
    required this.starttime,
    required this.endtime,
    required this.isCompleted,
  });
  factory TaskModel.fromJson(Map<String, dynamic> jsonData) {
    return TaskModel(
      id: jsonData['id'],
      date: jsonData['date'],
      color: jsonData['color'],
      title: jsonData['title'],
      note: jsonData['note'],
      starttime: jsonData['starttime'],
      endtime: jsonData['endtime'],
      isCompleted: jsonData['isCompleted'],
    );
  }
}
