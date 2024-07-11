import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/preference/preference_manager.dart';
import 'package:applematch/config/utils/validators.dart';
import 'package:applematch/features/auth/providers/auth_provider.dart';
// import 'package:applematch/features/auth/screens/verification_screen.dart';
import 'package:applematch/features/auth/widgets/auth_text_field.dart';
import 'package:applematch/features/auth/widgets/third_party_auth_button.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:applematch/services/auth.dart';
import 'package:applematch/shared/enums/text_field_state.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends ConsumerStatefulWidget {
  static const String route = "/signup";
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = ref.watch(authServiceProvider);
    final nameError = ref.watch(nameErrorProvider);
    final phoneNumberError = ref.watch(phoneNumberErrorProvider);
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);
    final isLoading = ref.watch(loadingProvider);

    return Scaffold(
      backgroundColor: AppColors.pink50,
      body: SafeArea(
        bottom: false,
        child: Container(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ! Back Button
                const AppBackButton(),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Create your\nAccount",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 38.spMin,
                          color: AppColors.pink500,
                        ),
                      ).left().animate(delay: 120.ms).fadeIn(),
                      SizedBox(height: 13.h),
                      // ! username
                      AuthTextField(
                        controller: _usernameController,
                        state: TextFieldState.username,
                        hintText: "Full Name",
                        capitalization: TextCapitalization.words,
                        icon: AppIcons.userIcon,
                        onChange: (value) {
                          if (value == null) {
                            ref.read(nameErrorProvider.notifier).state =
                                'Full name required';
                          }
                          ref.read(nameErrorProvider.notifier).state = null;
                        },
                      ),
                      // ! Name Error message
                      Visibility(
                        visible: nameError != null,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$nameError",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      // ! phone number
                      SizedBox(height: 20.h),
                      AuthTextField(
                        controller: _phoneController,
                        state: TextFieldState.phone,
                        keyboardType: TextInputType.number,
                        hintText: "Enter Your Phone Number",
                        icon: AppIcons.phone,
                        onChange: (value) {
                          if (value == null) {
                            ref.read(phoneNumberErrorProvider.notifier).state =
                                'Phone number required';
                          }
                          ref.read(phoneNumberErrorProvider.notifier).state =
                              null;
                        },
                      ),
                      // ! Phone number Error message
                      Visibility(
                        visible: phoneNumberError != null,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$phoneNumberError",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      // ! email
                      SizedBox(height: 20.h),
                      AuthTextField(
                        controller: _emailController,
                        state: TextFieldState.email,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter Your Email",
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
                      SizedBox(height: 16.h),

                      // ! password
                      AuthTextField(
                        controller: _passwordController,
                        state: TextFieldState.password,
                        hintText: "Password",
                        icon: AppIcons.lockIcon,
                        onChange: (value) {
                          if (value == null || value.isEmpty == true) {
                            ref.read(passwordErrorProvider.notifier).state =
                                "Password Required";
                            return null;
                          } else if (value.length < 8) {
                            ref.read(passwordErrorProvider.notifier).state =
                                'Password is should have a minimum of 8 characters';
                          } else {
                            ref.read(passwordErrorProvider.notifier).state =
                                null;
                          }
                        },
                      ),
                      // ! Password Error message
                      Visibility(
                        visible: passwordError != null,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "$passwordError",
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 40.h,
                        ),
                        child: Column(
                          children: [
                            PrimaryButton(
                              isLoading: isLoading,
                              onTap: () async {
                                ref.read(loadingProvider.notifier).state = true;
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                }
                                print(nameError);
                                print(phoneNumberError);
                                print(passwordError);
                                print(emailError);
                                if (nameError != null ||
                                    phoneNumberError != null ||
                                    passwordError != null ||
                                    emailError != null) return;
                                print("Tapped");

                                await authService
                                    .registerWithEmailAndPassword(
                                        _emailController.text,
                                        _passwordController.text,
                                        context)
                                    .then((result) {
                                  if (result == null) {
                                    return;
                                  } else {
                                    ref.read(loadingProvider.notifier).state =
                                        false;
                                    PreferenceManager.isloggedIn = true;
                                    PreferenceManager.isFirstLaunch = false;
                                    Navigator.of(context)
                                        .pushNamed(YourInterestScreen.route);
                                  }
                                });
                              },
                              // onTap:
                              //  () => Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => VerificationScreen(
                              //       verificationId: "",
                              //     ),
                              //   ),
                              // ),
                              text: "Sign up",
                            ),
                            SizedBox(height: 28.h),
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.grey200,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text(
                                    "Or",
                                    style: TextStyle(
                                      fontSize: 16.spMin,
                                      color: AppColors.grey700,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.grey200,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 40.h),
                            CustomAuthButton(
                              text: "Continue with Google",
                              icon: AppIcons.google,
                              onTap: () async {
                                await authService
                                    .signInWithGoogle()
                                    .then((result) {
                                  if (result == null) {
                                    return;
                                  } else {
                                    PreferenceManager.accessToken =
                                        result.credential?.accessToken ?? "";
                                    PreferenceManager.isloggedIn = true;
                                    PreferenceManager.isFirstLaunch = false;
                                    Navigator.of(context)
                                        .pushNamed(YourInterestScreen.route);
                                  }
                                });
                              },
                            ),
                            SizedBox(height: 20.h),
                            // CustomAuthButton(
                            //   text: "Continue with Facebook",
                            //   icon: AppIcons.facebook,
                            //   onTap: () {},
                            // ),
                            SizedBox(height: 8.h),
                          ],
                        ),
                      )
                    ],
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
