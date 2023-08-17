import 'package:get_it/get_it.dart';
import 'package:sesstion13/core/database/cache/cash_helper.dart';

final sl = GetIt.instance;
Future<void> setup() async {
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper());
}
