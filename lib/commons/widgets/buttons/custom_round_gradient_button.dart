import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:todo/constants/app_colors.dart';

class RoundGradientButton extends StatefulWidget {
  VoidCallback? onTap;
  IconData iconName;
  RoundGradientButton(
      {super.key,
      required this.onTap,
        required this.iconName,
      });

  @override
  State<RoundGradientButton> createState() => _RoundGradientButtonState();
}

class _RoundGradientButtonState extends State<RoundGradientButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 40,
        width: 40,
        padding:const EdgeInsets.all(1),
        decoration:  BoxDecoration(
          shape: BoxShape.circle,
          border: const GradientBoxBorder(
            gradient: AppColors.kButtonGradient,
            width: 2,
          ),
          color: AppColors.kPrimaryColor.withOpacity(0.4)
        ),
        child:
        Center(
          child: FaIcon(widget.iconName,color: AppColors.kSecondaryColor,size: 18,)
          // widget.icon,
        ),
      ),
    );
  }
}
