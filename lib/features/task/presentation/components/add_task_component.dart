import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class AddTaskComponent extends StatelessWidget {
  const AddTaskComponent(
      {super.key,
      required this.tilte,
      this.controller,
      this.suffixicon,
      required this.hintText,
      this.readOnly = false,
      this.valdator});
  final String tilte;
  final String hintText;
  final IconButton? suffixicon;
  final TextEditingController? controller;
  final bool readOnly;
  final String? Function(String?)? valdator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tilte,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: AppColors.white)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          readOnly: readOnly,
          controller: controller,
          validator: valdator,
          decoration:
              InputDecoration(hintText: hintText, suffixIcon: suffixicon),
        ),
      ],
    );
  }
}
