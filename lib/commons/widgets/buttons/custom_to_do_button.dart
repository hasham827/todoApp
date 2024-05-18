import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/constants/app_size.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_textstyle.dart';
class ToDoButton extends StatefulWidget {
  String? buttonText;
  VoidCallback? onTap;
  IconData iconName;
   ToDoButton({super.key,required this.iconName,required this.onTap,required this.buttonText});

  @override
  State<ToDoButton> createState() => _ToDoButtonState();
}

class _ToDoButtonState extends State<ToDoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: height(context)*0.15,
        width: 100,
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withOpacity(0.7),
            gradient: AppColors.kButtonGradient,
            borderRadius: BorderRadius.circular(25)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              padding:const EdgeInsets.all(1),
              decoration:   BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.kPrimaryColor.withOpacity(0.7),
                      width: 2
                  ),
                  color: AppColors.kSecondaryColor.withOpacity(0.3)
              ),
              child:
               Center(
                  child: FaIcon(widget.iconName,color: AppColors.kPrimaryColor,size: 25,)
                // widget.icon,
              ),
            ),
            SizedBox(height: height(context)*0.01,),
            Text(widget.buttonText.toString(),style: ubuntuMedium.copyWith(
                color: AppColors.kBlackTextColor,
                fontSize: kFont16
            ),)
          ],
        ),
      ),
    );
  }
}
