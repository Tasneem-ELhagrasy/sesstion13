import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sesstion13/core/them/theme.dart';
import 'package:sesstion13/core/utils/app_assets.dart';

import '../features/auth/presentation/screens/splash_screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          theme: getAppTheme(),
          themeMode: ThemeMode.light,
          title: AppAssets.logo,
        );
      },
    );
  }
}
