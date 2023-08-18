import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sesstion13/core/database/sqfite_helper/sqflite_helper.dart';
import 'package:sesstion13/core/services/service_locator.dart';
import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_state.dart';

import '../../../../../../../core/utils/app_colors.dart';
import '../../data/model/task_model.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  DateTime currentDate = DateTime.now();
  DateTime selectDate = DateTime.now();
  int currentindex = 0;
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController notecontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // get date
  void getDate(context) async {
    emit(GetDateLoadingState());
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(2025));

    if (pickedDate != null) {
      currentDate = pickedDate;
      emit(GetDateSucessState());
    } else {
      print('PickedDate==null');
      emit(GetDateErrorState());
    }
  }

  void getStartTime(context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedendTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (pickedendTime != null) {
      startTime = pickedendTime.format(context);
      emit(GetStartTimeSucessState());
    } else {
      print('PickedendTime==null');
      emit(GetStartTimeErrorState());
    }
  }

  void getEndTime(context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedendTime = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()));
    if (pickedendTime != null) {
      endTime = pickedendTime.format(context);
      emit(GetEndTimeSucessState());
    } else {
      print('PickedendTime==null');
      emit(GetEndTimeErrorState());
    }
  }

  Color getColor(index) {
    switch (index) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.bluegrey;
      case 3:
        return AppColors.sky;
      case 4:
        return AppColors.orange;
      case 5:
        return AppColors.pink;
      case 6:
        return AppColors.brown;
      default:
        return AppColors.deepgray;
    }
  }

  void changeCkeckMarkIndex(index) {
    currentindex = index;
    emit(ChangeCkeckMarkIndexState());
  }

  void getSelectedDate(date) {
    emit(GetSelectedDateLoadingState());
    selectDate = date;
    emit(GetSelectedDateSucessState());
    getTasks();
  }

  List<TaskModel> tasksList = [];
  void insertTaske() async {
    emit(InsertTaskLoadingState());
    try {
      await sl<SqfliteHelper>().insertToDB(TaskModel(
        date: DateFormat.yMd().format(currentDate),
        color: currentindex,
        title: titlecontroller.text,
        note: notecontroller.text,
        endtime: endTime,
        isCompleted: 0,
        starttime: startTime,
      ));
      getTasks();

      titlecontroller.clear();
      notecontroller.clear();
      emit(InsertTaskSucessState());
    } catch (e) {
      emit(InsertTaskErrorState());
    }
  }

  void getTasks() async {
    emit(GetDateLoadingState());
    await sl<SqfliteHelper>().getFromDB().then((value) {
      tasksList = value
          .map((e) => TaskModel.fromJson(e))
          .toList()
          .where(
            (element) => element.date == DateFormat.yMd().format(selectDate),
          )
          .toList();
      emit(GetDateSucessState());
    }).catchError((e) {
      print(e.toString());
      emit(GetDateErrorState());
    });
  }

  void updateTask(id) async {
    emit(UpdateTaskLoadingState());
    await sl<SqfliteHelper>().updateToDB(id).then((value) {
      emit(UpdateTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(UpdateTaskErrorState());
    });
  }

  void deleteTaske(id) async {
    emit(DeleteTaskLoadingState());
    await sl<SqfliteHelper>().deleteFromDB(id).then((value) {
      emit(DeleteTaskSucessState());
      getTasks();
    }).catchError((e) {
      print(e.toString());
      emit(DeleteTaskErrorState());
    });
  }
}
