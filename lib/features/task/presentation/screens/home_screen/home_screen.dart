import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sesstion13/core/customs/customs.dart';
import 'package:sesstion13/core/utils/app_assets.dart';
import 'package:sesstion13/core/utils/app_colors.dart';
import 'package:sesstion13/core/utils/app_strings.dart';
import 'package:sesstion13/core/widgets/coustom_buttom.dart';
import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_cubit.dart';
import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_state.dart';

import '../../features/task/data/model/task_model.dart';
import '../add_task_screen/add_task_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(DateFormat.yMMMMd().format(DateTime.now()),
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 12),
                  Text(AppStrings.today,
                      style: Theme.of(context).textTheme.displayLarge),
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.deepgray,
                    selectedTextColor: AppColors.white,
                    dayTextStyle: Theme.of(context).textTheme.displayMedium!,
                    monthTextStyle: Theme.of(context).textTheme.displayMedium!,
                    dateTextStyle: Theme.of(context).textTheme.displayMedium!,
                    onDateChange: (date) {
                      BlocProvider.of<TaskCubit>(context).getSelectedDate(date);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  BlocProvider.of<TaskCubit>(context).tasksList.isEmpty
                      ? noTasksWidget(context)
                      : Expanded(
                          child: ListView.builder(
                              itemCount: BlocProvider.of<TaskCubit>(context)
                                  .tasksList
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(24),
                                              height: 240,
                                              color: AppColors.deepgray,
                                              child: Column(
                                                children: [
                                                  BlocProvider.of<TaskCubit>(
                                                                  context)
                                                              .tasksList[index]
                                                              .isCompleted ==
                                                          1
                                                      ? Container()
                                                      :
                                                      // task
                                                      SizedBox(
                                                          height: 48,
                                                          width:
                                                              double.infinity,
                                                          child: CustomButtom(
                                                              text: AppStrings
                                                                  .taskcompleted,
                                                              onPressed: () {
                                                                BlocProvider.of<
                                                                            TaskCubit>(
                                                                        context)
                                                                    .updateTask(BlocProvider.of<TaskCubit>(
                                                                            context)
                                                                        .tasksList[
                                                                            index]
                                                                        .id);
                                                                Navigator.pop(
                                                                    context);
                                                              }),
                                                        ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  // delet
                                                  SizedBox(
                                                    height: 48,
                                                    width: double.infinity,
                                                    child: CustomButtom(
                                                        text: AppStrings
                                                            .deletetask,
                                                        backgroundColor:
                                                            AppColors.red,
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      TaskCubit>(
                                                                  context)
                                                              .deleteTaske(BlocProvider
                                                                      .of<TaskCubit>(
                                                                          context)
                                                                  .tasksList[
                                                                      index]
                                                                  .id);
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  ),
                                                  const SizedBox(
                                                    height: 24,
                                                  ),
                                                  // cancel
                                                  SizedBox(
                                                    height: 48,
                                                    width: double.infinity,
                                                    child: CustomButtom(
                                                        text: AppStrings.cancel,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: TaskComponent(
                                      taskModel:
                                          BlocProvider.of<TaskCubit>(context)
                                              .tasksList[index],
                                    ));
                              }),
                        )
                ],
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigate(context: context, screen: AddTaskScreen());
        },
        backgroundColor: AppColors.purple,
        child: const Icon(Icons.add),
      ),
    ));
  }

  Column noTasksWidget(BuildContext context) {
    return Column(
      children: [
        Image.asset(AppAssets.logo5),
        const SizedBox(
          height: 12,
        ),
        Text(AppStrings.noTaskTaital,
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(fontSize: 24)),
        const SizedBox(
          height: 12,
        ),
        Text(AppStrings.noTasksubTaital,
            style: Theme.of(context).textTheme.displayMedium)
      ],
    );
  }
}

class TaskComponent extends StatelessWidget {
  const TaskComponent({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;

  get index => null;
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

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: 128,
        decoration: BoxDecoration(
            color: getColor(taskModel.color),
            borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.alarm,
                        color: AppColors.white,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${taskModel.starttime} -${taskModel.endtime}',
                        style: Theme.of(context).textTheme.displayMedium,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    taskModel.note,
                    style: Theme.of(context).textTheme.displayLarge,
                  )
                ],
              ),
            ),
            Container(
              height: 75,
              width: 1.5,
              color: AppColors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                taskModel.isCompleted == 1
                    ? AppStrings.completed
                    : AppStrings.todo,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      color: AppColors.white,
                    ),
              ),
            )
          ],
        ));
  }
}
