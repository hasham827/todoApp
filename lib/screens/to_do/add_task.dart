import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/app_textstyle.dart';
import 'package:todo/constants/app_validations.dart';

import '../../commons/widgets/buttons/custom_round_gradient_button.dart';
import '../../commons/widgets/buttons/custom_text_button.dart';
import '../../commons/widgets/input_fields/cutom_input_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../../provider/home_provider.dart';

class AddTaskView extends StatefulWidget {
  bool isUpdate;

  AddTaskView({super.key, this.isUpdate = false});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: provider.loading,
      progressIndicator: const Center(child: CircularProgressIndicator()
      ),
      child: Scaffold(
        backgroundColor: AppColors.kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leadingWidth: width(context) * 0.2,
          title: Text(
            "Add Task",
            style: ubuntuSemiBold.copyWith(
                color: AppColors.kBlackTextColor, fontSize: kFont20),
          ),
          leading: Center(
            child: RoundGradientButton(
              iconName: FontAwesomeIcons.arrowLeft,
              onTap: () {
                Get.back();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width(context) * 0.05,
          ),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height(context) * 0.09,
                ),
                Text(
                  'Task title',
                  style: ubuntuMedium.copyWith(
                      color: AppColors.kBlackTextColor, fontSize: kFont18),
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),

                /// title field here
                CustomTextFiled(
                  controller: provider.title,
                  hintText: "Task title",
                  validator: (value) {
                    return AppValidations().valueRequired(
                      value,
                      errorText: 'Title is required',
                    );
                  },
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),

                /// date time here
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: ubuntuMedium.copyWith(
                              color: AppColors.kBlackTextColor,
                              fontSize: kFont18),
                        ),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        SizedBox(
                          width: width(context) * 0.450,
                          child: CustomTextFiled(
                            controller: provider.date,
                            readOnly: true,
                            onTap: () {
                              provider.selectDate(context);
                            },
                            hintText: "Select date",
                            sufixIcon: FontAwesomeIcons.calendar,
                            validator: (value) {
                              return AppValidations().valueRequired(
                                value,
                                errorText: 'Date is required',
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    /// time pickeere is here
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Time',
                          style: ubuntuMedium.copyWith(
                              color: AppColors.kBlackTextColor,
                              fontSize: kFont18),
                        ),
                        SizedBox(
                          height: height(context) * 0.01,
                        ),
                        SizedBox(
                          width: width(context) * 0.42,
                          child: CustomTextFiled(
                            controller: provider.time,
                            readOnly: true,
                            onTap: () {
                              provider.showStartTimePicker(context);
                            },
                            hintText: "Select time",
                            validator: (value) {
                              return AppValidations().valueRequired(
                                value,
                                errorText: 'Time is required',
                              );
                            },
                            sufixIcon: FontAwesomeIcons.clock,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                widget.isUpdate?
                Column(
                  children: [
                    SizedBox(
                      height: height(context) * 0.02,
                    ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Status",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.kPrimaryColor,
                          ),
                        ),
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
                      value: provider.selectedStatus,
                      items: provider.statusOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          provider.selectedStatus = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a status';
                        }
                        return null;
                      },
                    )
                  ],
                ):
                const SizedBox(),
                SizedBox(
                  height: height(context) * 0.02,
                ),
                Text(
                  'Description',
                  style: ubuntuMedium.copyWith(
                      color: AppColors.kBlackTextColor, fontSize: kFont18),
                ),
                SizedBox(
                  height: height(context) * 0.01,
                ),

                CustomTextFiled(
                  controller: provider.description,
                  readOnly: false,
                  hintText: "Task description",
                  minLines: 3,
                  maxLines: 7,
                  validator: (value) {
                    return AppValidations().valueRequired(
                      value,
                      errorText: 'Description is required',
                    );
                  },
                ),
                SizedBox(
                  height: height(context) * 0.08,
                ),
                Center(
                  child: widget.isUpdate?
                  CustomTextButton(
                    onTap: () async {
                      // Provider.of<HomeProvider>(context, listen: false).saveNote();
                      await provider.updateTodo();
                    },
                    buttonText: 'Update Task',
                    buttonHeight: 50.0,
                    buttonWidth: width(context) * 0.8,
                  ):
                  CustomTextButton(
                    onTap: () async {
                      // Provider.of<HomeProvider>(context, listen: false).saveNote();
                      provider.addTask();
                    },
                    buttonText: 'Save Task',
                    buttonHeight: 50.0,
                    buttonWidth: width(context) * 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
