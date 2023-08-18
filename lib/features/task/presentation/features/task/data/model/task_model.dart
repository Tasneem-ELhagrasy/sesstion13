class TaskModel {
  final String id;
  final String title;
  final String note;
  final String starttime;
  final String endtime;

  final bool isCompleted;
  final int color;

  TaskModel({
    required this.color,
    required this.id,
    required this.title,
    required this.note,
    required this.starttime,
    required this.endtime,
    required this.isCompleted,
  });
  static List<TaskModel> tasksList = [
    TaskModel(
      id: '1',
      title: 'Task 1',
      note: 'Learn Dart',
      starttime: '09:33 PM',
      endtime: '09:48 PM',
      isCompleted: false,
      color: 0,
    ),
    TaskModel(
      id: '2',
      title: 'Task 2',
      note: 'Learn SQFLITE ',
      starttime: '09:33 PM',
      endtime: '09:48 PM',
      isCompleted: true,
      color: 4,
    ),
  ];
}
