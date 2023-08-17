import 'package:flutter/material.dart';
import 'package:sesstion13/core/utils/app_colors.dart';

// ignore: must_be_immutable
class CustomButtom extends StatelessWidget {
  CustomButtom(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor = AppColors.purple});
  final String text;
  final VoidCallback onPressed;
  Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              backgroundColor: MaterialStateProperty.all(backgroundColor),
            ),
        child: Text(
          text,
        ));
  }
}
