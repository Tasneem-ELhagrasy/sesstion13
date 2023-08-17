import 'package:sesstion13/core/utils/app_assets.dart';
import 'package:sesstion13/core/utils/app_strings.dart';

class OnBoardingModel {
  final String imgPath;
  final String title;
  final String pra;
  OnBoardingModel(
      {required this.imgPath, required this.title, required this.pra});
  static List<OnBoardingModel> OnBoardingScreens = [
    OnBoardingModel(
        imgPath: AppAssets.logo2,
        title: AppStrings.firsttital,
        pra: AppStrings.firstpra),
    OnBoardingModel(
        imgPath: AppAssets.logo3,
        title: AppStrings.sectital,
        pra: AppStrings.secpra),
    OnBoardingModel(
        imgPath: AppAssets.logo4,
        title: AppStrings.thirdtital,
        pra: AppStrings.thirdpra),
  ];
}
