import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/constants/app_textstyle.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_size.dart';

class CustomTextField extends StatelessWidget {
  final String heading;
  final TextEditingController controller;
  final String hintText;
  final bool? isObscure;
  final String? obscureCharacter;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final double? outerBottomPadding;
  final double? horizontalPadding;
  final bool? enabled;
  final int? minLines;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.heading,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.obscureCharacter = '*',
    this.keyboardType,
    this.validator,
    this.inputFormatter,
    this.onChanged,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.outerBottomPadding,
    this.horizontalPadding,
    this.enabled,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// heading
          Text(
            heading,
            style: ubuntuMedium.copyWith(
              color: AppColors.kBlackTextColor,
              fontSize: kFont18
            ),
          ),
          SizedBox(height: height(context) * 0.01),

          /// field
          TextFormField(
            controller: controller,
            obscureText: isObscure!,
            obscuringCharacter: obscureCharacter!,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatter,
            onChanged: onChanged,
            textInputAction: textInputAction,
            enabled: enabled,
            minLines: minLines,
            maxLines: maxLines,
            style: ubuntuMedium.copyWith(
              color: AppColors.kBlackTextColor,
              fontSize: kFont14
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.kWhiteColor.withOpacity(0.5),
              hintText: hintText,
              hintStyle: ubuntuMedium.copyWith(
                  color: AppColors.kGreyTextColor,
                  fontSize: kFont14
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: kPadding16,
                vertical: kPadding12,
              ),
              suffixIcon: suffixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius12),
                borderSide: BorderSide(
                  color: AppColors.kSecondaryColor.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius12),
                borderSide: const BorderSide(
                  color: AppColors.kSecondaryColor,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kRadius12),
                borderSide: BorderSide(
                  color: AppColors.kSecondaryColor.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
            ),
          ),

          SizedBox(height: outerBottomPadding ?? height(context) * 0.016),
        ],
      ),
    );
  }
}
