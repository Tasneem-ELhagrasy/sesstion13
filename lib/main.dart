import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sesstion13/features/task/presentation/features/task/presentation/cubit/task_cubit.dart';

import 'app/app.dart';
import 'core/database/cache/cash_helper.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  await sl<CacheHelper>().init();
  runApp(BlocProvider(
    create: (context) => TaskCubit(),
    child: const MyApp(),
  ));
}
