import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';


class TopCircleWidget extends StatelessWidget {
  const TopCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Transform.translate(
        offset: Offset(
          height(context) * 0.08,
          -(height(context) * 0.07),
        ),
        child: Container(
          height: height(context) * 0.24,
          width: height(context) * 0.24,
          decoration:   BoxDecoration(
              shape: BoxShape.circle,
              border: const GradientBoxBorder(
                gradient: AppColors.kBorderGradient,
                width: 2,
              ),
              color: AppColors.kPrimaryColor.withOpacity(0.4)
          ),
        ),
      ),
    );
  }
}
