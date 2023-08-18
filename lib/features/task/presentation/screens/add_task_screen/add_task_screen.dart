import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sesstion13/core/utils/app_colors.dart';

import 'package:sesstion13/core/utils/app_strings.dart';
import 'package:sesstion13/core/widgets/coustom_buttom.dart';

import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_cubit.dart';
import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_state.dart';

import '../../../../../core/customs/customs.dart';
import '../../components/add_task_component.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          AppStrings.addtask,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is InsertTaskSucessState) {
                showToast(message: 'added sucess', state: ToastStates.success);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              // ignore: unused_local_variable
              final cubit = BlocProvider.of<TaskCubit>(context);
              return Form(
                key: BlocProvider.of<TaskCubit>(context).formkey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      AddTaskComponent(
                        controller:
                            BlocProvider.of<TaskCubit>(context).titlecontroller,
                        tilte: AppStrings.title,
                        hintText: AppStrings.titleHint,
                        valdator: (val) {
                          if (val!.isEmpty) {
                            return AppStrings.titleerror;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // note
                      AddTaskComponent(
                        controller:
                            BlocProvider.of<TaskCubit>(context).notecontroller,
                        tilte: AppStrings.note,
                        hintText: AppStrings.noteHint,
                        valdator: (val) {
                          if (val!.isEmpty) {
                            return AppStrings.noteerror;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // date
                      AddTaskComponent(
                        tilte: AppStrings.date,
                        hintText: DateFormat.yMd().format(
                            BlocProvider.of<TaskCubit>(context).currentDate),
                        suffixicon: IconButton(
                            onPressed: () async {
                              BlocProvider.of<TaskCubit>(context)
                                  .getDate(context);
                            },
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              color: AppColors.white,
                            )),
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // start_end
                      Row(
                        children: [
                          Expanded(
                            child: AddTaskComponent(
                              readOnly: true,
                              tilte: AppStrings.starttime,
                              hintText:
                                  BlocProvider.of<TaskCubit>(context).startTime,
                              suffixicon: IconButton(
                                  onPressed: () async {
                                    BlocProvider.of<TaskCubit>(context)
                                        .getStartTime(context);
                                  },
                                  icon: const Icon(
                                    Icons.alarm_outlined,
                                    color: AppColors.white,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 26.w,
                          ),
                          Expanded(
                            child: AddTaskComponent(
                              readOnly: true,
                              tilte: AppStrings.endtime,
                              hintText:
                                  BlocProvider.of<TaskCubit>(context).endTime,
                              suffixicon: IconButton(
                                  onPressed: () async {
                                    BlocProvider.of<TaskCubit>(context)
                                        .getEndTime(context);
                                  },
                                  icon: const Icon(
                                    Icons.alarm_outlined,
                                    color: AppColors.white,
                                  )),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // colors
                      SizedBox(
                        height: 68.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.color,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: AppColors.white),
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 6,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<TaskCubit>(context)
                                              .changeCkeckMarkIndex(index);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              BlocProvider.of<TaskCubit>(
                                                      context)
                                                  .getColor(index),
                                          child: index ==
                                                  BlocProvider.of<TaskCubit>(
                                                          context)
                                                      .currentindex
                                              ? const Icon(Icons.check)
                                              : null,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                      // add taske button
                      state is InsertTaskLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: AppColors.purple,
                              ),
                            )
                          : SizedBox(
                              height: 48.h,
                              width: double.infinity,
                              child: CustomButtom(
                                  text: AppStrings.createtask,
                                  onPressed: () {
                                    if (BlocProvider.of<TaskCubit>(context)
                                        .formkey
                                        .currentState!
                                        .validate()) {
                                      BlocProvider.of<TaskCubit>(context)
                                          .insertTaske();
                                    }
                                  }),
                            ),
                    ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
