import 'package:flutter/material.dart';
import 'package:sesstion13/core/database/cache/cash_helper.dart';
import 'package:sesstion13/core/services/service_locator.dart';

import 'package:sesstion13/core/utils/app_assets.dart';
import 'package:sesstion13/core/utils/app_colors.dart';
import 'package:sesstion13/core/utils/app_strings.dart';
import 'package:sesstion13/features/auth/presentation/screens/on_boarding_screens/on_boarding_screens.dart';

import '../../../../task/presentation/screens/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  void navigate() {
    bool isVisited =
        sl<CacheHelper>().getData(key: AppStrings.onBoardingKey) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  isVisited ? const HomeScreen() : OnBoardingScreen1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo),
            const SizedBox(
              height: 48,
            ),
            Text(
              AppStrings.appName,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 40,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
