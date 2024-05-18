import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../commons/widgets/auth_base_widget.dart';
import '../../commons/widgets/buttons/custom_text_button.dart';
import '../../commons/widgets/input_fields/custom_text_field.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_size.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_validations.dart';
import '../../provider/login_provider.dart';
import '../../provider/session_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider provider = Provider.of<LoginProvider>(context);
    SessionProvider session = Provider.of<SessionProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ModalProgressHUD(
        inAsyncCall: provider.loading,
        progressIndicator: const Center(child: CircularProgressIndicator()
        ),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: AppColors.kPrimaryColor,
          /// body
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.kBorderGradient
            ),
            child: AuthBaseWidget(
              titleText: AppStrings.login,
              subTitleText: AppStrings.enterYourLoginDetailsHere,
              child: Form(
                key: provider.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// email field
                      SizedBox(height: height(context) * 0.1),
                      CustomTextField(
                        heading: AppStrings.username,
                        controller: provider.usernameController,
                        hintText: AppStrings.enterYourName,
                        validator: AppValidations().validateUserName,
                      ),

                      /// pass field
                      CustomTextField(
                        heading: AppStrings.password,
                        controller: provider.passwordController,
                        hintText: AppStrings.enterYourPassword,
                        isObscure: provider.isPassObscure,
                        suffixIcon: IconButton(
                          onPressed: () {
                            provider.passObscureFun();
                          },
                          icon: FaIcon(
                            provider.isPassObscure
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: AppColors.kSecondaryColor,
                          ),
                        ),
                        outerBottomPadding: kPadding8,
                        validator: AppValidations().validatePassword,
                      ),

                      /// forgot password
                      // const ForgotPassButton(),

                      /// login button
                      SizedBox(height: height(context) * 0.03),
                      CustomTextButton(
                        onTap: () {
                          provider.onLogin();
                        },
                        buttonText: AppStrings.login,
                        buttonHeight: 50,
                        buttonWidth: width(context),
                      ),

                      /// don't have an account
                      SizedBox(height: height(context) * 0.01),
                      // const DontHaveAccount(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
