import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/constants/app_colors.dart';
import 'package:todo/constants/app_size.dart';
import 'package:todo/constants/app_textstyle.dart';

class CustomTextFiled extends StatefulWidget {
  TextEditingController controller;
  String? hintText;
  int? maxLines;
  int minLines;
  bool readOnly;
  VoidCallback? onTap;
  IconData? sufixIcon;
  final String? Function(String?)? validator;

  CustomTextFiled(
      {super.key,
      required this.controller,
      required this.hintText,
      this.maxLines = 2,
      this.minLines = 1,
      this.sufixIcon,
      this.validator,
      this.onTap,
      this.readOnly = false});

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.kPrimaryColor,
          ),
        ),
        suffixIcon: widget.sufixIcon == null
            ? const SizedBox()
            : Center(
                child: FaIcon(
                widget.sufixIcon,
                color: AppColors.kGreyTextColor,
                size: 20,
              )),
        suffixIconConstraints: const BoxConstraints(
            minHeight: 40, maxHeight: 40, minWidth: 40, maxWidth: 40),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(12)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.kPrimaryColor,
            ),
            borderRadius: BorderRadius.circular(12)),
        hintStyle: ubuntuRegular.copyWith(
            color: AppColors.kGreyTextColor, fontSize: kFont16),
      ),
    );
  }
}
