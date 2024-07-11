import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/utils/validators.dart';
import 'package:applematch/features/auth/providers/auth_provider.dart';
import 'package:applematch/features/auth/screens/verify_email_screen.dart';
import 'package:applematch/features/auth/widgets/auth_text_field.dart';
import 'package:applematch/services/auth.dart';
import 'package:applematch/shared/enums/text_field_state.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static const String route = '/forgot-password';
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailError = ref.watch(emailErrorProvider);
    final authService = ref.watch(authServiceProvider);

    return Scaffold(
      backgroundColor: AppColors.pink50,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.pink50,
                    AppColors.pink50,
                    Colors.white,
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 239.h, left: 24.w, right: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                          fontSize: 38.spMin,
                          fontWeight: FontWeight.w600,
                          color: AppColors.pink500,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      AuthTextField(
                        controller: _emailController,
                        state: TextFieldState.email,
                        hintText: "Enter Your Email address",
                        icon: AppIcons.emailIcon,
                        onChange: (value) {
                          final error = validateEmail?.call(value);
                          ref.read(emailErrorProvider.notifier).state = error;
                        },
                      ),
                      // ! Email Error message
                      Visibility(
                        visible: emailError != null,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$emailError",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      PrimaryButton(
                        text: "Continue",
                        onTap: () async {
                          if (emailError != null) return;
                          ref.read(loadingProvider.notifier).state = true;

                          await authService
                              .resetPassword(
                                  email: _emailController.text,
                                  context: context)
                              .then((result) {
                            if (result == true) {
                              Navigator.of(context)
                                  .pushNamed(VerifyEmailScreen.route);
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            // ! Back Button
            SafeArea(
              minimum: EdgeInsets.only(left: 30.w),
              child: const AppBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
