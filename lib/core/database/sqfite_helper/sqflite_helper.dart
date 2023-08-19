import 'package:sesstion13/features/task/presentation/features/task/data/model/task_model.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteHelper {
  late Database db;
  void intDB() async {
    db = await openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (Database db, int v) async {
        await db.execute('''
CREATE TABLE Tasks(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  note TEXT,
  date TEXT,
  starttime TEXT,
  endtime TEXT,
  color INTEGER,
  isCompleted INTEGER)

            ''').then((value) => print('DB created successfully'));
      },
      onOpen: (db) => print('Database opened'),
    ).then((value) => db = value).catchError((e) {
      print(e.toString());
    });
  }

  Future<List<Map<String, dynamic>>> getFromDB() async {
    return await db.rawQuery('select * from Tasks');
  }

  Future<int> insertToDB(TaskModel model) async {
    return await db.rawInsert('''
      INSERT INTO Tasks(
        title ,note ,date ,starttime ,endtime ,color ,isCompleted )
      Values
      ('${model.title}','${model.note}','${model.date}',
      '${model.starttime}','${model.endtime}','${model.color}',
      '${model.isCompleted}')
      ''');
  }

  Future<int> updateToDB(int id) async {
    return await db.rawUpdate('''
UPDATE Tasks
SET isCompleted =?
 WHERE id =?
''', [1, id]);
  }

  Future<int> deleteFromDB(int id) async {
    return await db.rawDelete('''
      DELETE FROM tasks WHERE id =?''', [id]);
  }
}
