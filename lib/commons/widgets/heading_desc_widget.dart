import 'package:flutter/material.dart';
import 'package:todo/constants/app_textstyle.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';

class HeadingDescWidget extends StatelessWidget {
  final String headingText;
  final String descText;

  const HeadingDescWidget({
    super.key,
    required this.headingText,
    required this.descText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: kPadding20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: height(context) * 0.03),
          Text(
            headingText,
            style: ubuntuSemiBold.copyWith(
              color: AppColors.kWhiteColor,
                fontSize: kFont20
            ),
          ),
          SizedBox(height: height(context) * 0.01),
          Text(
            descText,
            style: ubuntuSemiBold.copyWith(
              color: AppColors.kWhiteColor,
              fontSize: kFont18
            ),
          ),
        ],
      ),
    );
  }
}
