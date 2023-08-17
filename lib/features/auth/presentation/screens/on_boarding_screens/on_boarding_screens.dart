import 'package:flutter/material.dart';
import 'package:sesstion13/core/customs/customs.dart';

import 'package:sesstion13/core/database/cache/cash_helper.dart';
import 'package:sesstion13/core/services/service_locator.dart';

import 'package:sesstion13/core/utils/app_colors.dart';
import 'package:sesstion13/core/utils/app_strings.dart';
import 'package:sesstion13/core/widgets/coustom_buttom.dart';
import 'package:sesstion13/core/widgets/coustom_text_buttom.dart';
import 'package:sesstion13/features/auth/data/model/on_boading_model.dart';
import 'package:sesstion13/features/task/presentation/screens/home_screen/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class OnBoardingScreen1 extends StatelessWidget {
  OnBoardingScreen1({super.key});
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: PageView.builder(
            controller: controller,
            itemCount: OnBoardingModel.OnBoardingScreens.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  index != 2
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: CustomTextButton(
                            text: AppStrings.skip,
                            onPressed: () {
                              controller.jumpToPage(2);
                            },
                          ),
                        )
                      : const SizedBox(
                          height: 50,
                        ),
                  // image
                  Image.asset(OnBoardingModel.OnBoardingScreens[index].imgPath),
                  const SizedBox(
                    height: 16,
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: AppColors.white,
                      dotColor: AppColors.deepgray,
                      dotHeight: 4,
                      dotWidth: 6,
                      spacing: 9,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // tital
                  Text(OnBoardingModel.OnBoardingScreens[index].title,
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(
                    height: 30,
                  ),
                  // subtital
                  Align(
                    alignment: Alignment.center,
                    child: Text(OnBoardingModel.OnBoardingScreens[index].pra,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                  const SizedBox(
                    height: 130,
                  ),
                  // tital
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index != 0
                          ? CustomTextButton(
                              text: AppStrings.back,
                              onPressed: () {
                                controller.previousPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                            )
                          : Container(),
                      const Spacer(),
                      index != 2
                          ? CustomButtom(
                              text: AppStrings.next,
                              onPressed: () {
                                controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastLinearToSlowEaseIn);
                              },
                            )
                          : CustomButtom(
                              text: AppStrings.get,
                              onPressed: () async {
                                await sl<CacheHelper>()
                                    .saveData(
                                        key: AppStrings.onBoardingKey,
                                        value: true)
                                    .then((valu) {
                                  navigate(
                                      context: context,
                                      screen: const HomeScreen());
                                });
                              },
                            )
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
