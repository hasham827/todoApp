import 'package:flutter/material.dart';
import 'package:todo/commons/widgets/top_circle_widget.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import 'heading_desc_widget.dart';

class AuthBaseWidget extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Widget child;

  const AuthBaseWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height(context)*0.1,),
              /// heading text widget
              HeadingDescWidget(
                headingText: titleText,
                descText: subTitleText,
              ),
              SizedBox(height: height(context) * 0.06),
              Expanded(
                child: Container(
                  height: height(context),
                  width: width(context),
                  padding: EdgeInsets.symmetric(horizontal: kPadding20),
                  decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kRadius30),
                      topRight: Radius.circular(kRadius30),
                    ),
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),

        ///
        const TopCircleWidget(),
      ],
    );
  }
}
