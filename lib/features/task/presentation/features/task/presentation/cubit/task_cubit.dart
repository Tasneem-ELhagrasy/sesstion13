import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_state.dart';

import '../../../../../../../core/utils/app_colors.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  String startTime = DateFormat('hh:mm a').format(DateTime.now());
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 45)));
  DateTime currentDate = DateTime.now();
  int currentindex = 0;
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
      default:
        return AppColors.deepgray;
    }
  }

  void changeCkeckMarkIndex(index) {
    currentindex = index;
    emit(changeCkeckMarkIndexState());
  }
}
