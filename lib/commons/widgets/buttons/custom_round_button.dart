import 'package:flutter/material.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_textstyle.dart';
class CustomRoundButton extends StatefulWidget {
  String? iconPath;
  VoidCallback? onTap;
  String? text;
   CustomRoundButton({super.key,required this.onTap,required this.iconPath,required this.text});

  @override
  State<CustomRoundButton> createState() => _CustomRoundButtonState();
}

class _CustomRoundButtonState extends State<CustomRoundButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration:  const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.kButtonGradient,
          ),
          child: Center(
            child: Image.asset(widget.iconPath.toString(),
            width: 22,height: 22,),
          ),
        ),
        Text("${widget.text}",style: ubuntuSemiBold.copyWith(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.w500,
          height: 1.9,
          letterSpacing:1
        ),),
      ],
    );
  }
}
