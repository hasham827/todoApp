import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constants/app_strings.dart';
import 'package:todo/constants/app_textstyle.dart';
import 'package:todo/screens/to_do/add_task.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_size.dart';
class EmptyWidget extends StatefulWidget {
  const EmptyWidget({super.key});

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  @override
  Widget build(BuildContext context) {
    return    GestureDetector(
      onTap: (){
        Get.to(()=>AddTaskView(
          isUpdate: false,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.kPrimaryColor.withOpacity(0.7),
            gradient: AppColors.kButtonGradient,
            borderRadius: BorderRadius.circular(kRadius12)
        ),
        padding: const EdgeInsets.all(20),
        width: width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.dontHaveTaskToday,
              style: ubuntuRegular.copyWith(
                color: AppColors.kBlackTextColor,
                fontSize: kFont24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height(context)*0.015,),
            Text(
              AppStrings.clickHere,
              style: ubuntuMedium.copyWith(
                color: AppColors.kBlackTextColor,
                fontSize: kFont20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
