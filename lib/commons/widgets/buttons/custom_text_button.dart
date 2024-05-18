import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_size.dart';
import 'package:todo/constants/app_textstyle.dart';
class CustomTextButton extends StatefulWidget {
  VoidCallback? onTap;
  String? buttonText;
  double? buttonHeight;
  double? buttonWidth;
  CustomTextButton({super.key,
    required this.onTap,
    required this.buttonText,
  required this.buttonHeight,required this.buttonWidth});

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            border: const GradientBoxBorder(
              gradient: AppColors.kButtonGradient,
              width: 2,
            ),
            gradient: AppColors.kBorderGradient,
            color: AppColors.kPrimaryColor
        ),
        child: Center(
          child: Text(widget.buttonText.toString(),style: ubuntuSemiBold.copyWith(
            color: AppColors.kBlackTextColor,
            fontSize: kFont18,
          ),),
        ),
      ),
    );
  }
}
