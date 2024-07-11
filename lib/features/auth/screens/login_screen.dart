import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/preference/preference_manager.dart';
import 'package:applematch/config/utils/validators.dart';
import 'package:applematch/features/auth/providers/auth_provider.dart';
import 'package:applematch/features/auth/screens/forgot_password_screen.dart';
import 'package:applematch/features/auth/screens/phone_number_screen.dart';
import 'package:applematch/features/auth/screens/signup_screen.dart';
import 'package:applematch/features/auth/widgets/auth_text_field.dart';
import 'package:applematch/features/auth/widgets/third_party_auth_button.dart';
import 'package:applematch/features/home/screens/home_screen.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:applematch/services/auth.dart';
import 'package:applematch/shared/enums/text_field_state.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String route = "/login";
  final bool showBackButton;
  const LoginScreen({super.key, this.showBackButton = true});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool rememberMe = true;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.pink50,
      ),
    );
    final _auth = ref.watch(authenticationProvider);
    final authService = ref.watch(authServiceProvider);
    final emailError = ref.watch(emailErrorProvider);
    final passwordError = ref.watch(passwordErrorProvider);

    return Scaffold(
      backgroundColor: AppColors.pink50,
      body: SafeArea(
        bottom: false,
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
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 66.h),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login Your\nAccount",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 38.spMin,
                            color: AppColors.pink500,
                          ),
                        ).left().animate(delay: 120.ms).fadeIn(),
                        SizedBox(height: 13.h),
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
                        AuthTextField(
                          controller: _passwordController,
                          state: TextFieldState.password,
                          hintText: "Password",
                          icon: AppIcons.lockIcon,
                          onChange: (value) {
                            if (value == null || value.isEmpty == true) {
                              ref.read(passwordErrorProvider.notifier).state =
                                  "Password Required";
                            } else if (value.length < 8) {
                              ref.read(passwordErrorProvider.notifier).state =
                                  'Password is should have a minimum of 8 characters';
                            } else {
                              ref.read(passwordErrorProvider.notifier).state =
                                  null;
                            }
                          },
                        ),
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
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox.adaptive(
                                  activeColor: AppColors.green200,
                                  value: rememberMe,
                                  onChanged: (value) {
                                    setState(() => rememberMe = value!);
                                  },
                                ),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                    color: AppColors.black100,
                                    fontSize: 12.spMin,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(ForgotPasswordScreen.route);
                              },
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: AppColors.grey700,
                                  fontSize: 12.spMin,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 40.h,
                          ),
                          child: Column(
                            children: [
                              PrimaryButton(
                                  text: "Log In",
                                  isLoading: authService.isLoading,
                                  onTap: () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }
                                    if (passwordError != null ||
                                        emailError != null) return;
                                    ref.read(loadingProvider.notifier).state =
                                        true;

                                    await authService
                                        .signInWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text,
                                            context)
                                        .then((result) {
                                      if (result == null) {
                                        return;
                                      } else {
                                        PreferenceManager.isloggedIn = true;
                                        PreferenceManager.isFirstLaunch = false;
                                        if (PreferenceManager.isRegistered) {
                                          Navigator.of(context)
                                              .pushNamed(HomeScreen.route);
                                        } else {
                                          Navigator.of(context).pushNamed(
                                              YourInterestScreen.route);
                                        }
                                      }
                                    });

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           VerificationScreen(
                                    //         verificationId: "",
                                    //       ),
                                    //     ));
                                  }),
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
                                text: "Login with Phone Number",
                                icon: AppIcons.phoneIcon,
                                onTap: () async {
                                  Navigator.of(context)
                                      .pushNamed(PhoneNumberScreen.route);
                                },
                              ),
                              SizedBox(height: 20.h),
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
                                      PreferenceManager.isloggedIn = true;
                                      PreferenceManager.isFirstLaunch = false;
                                      if (PreferenceManager.isRegistered) {
                                        Navigator.of(context)
                                            .pushNamed(HomeScreen.route);
                                      } else {
                                        Navigator.of(context).pushNamed(
                                            YourInterestScreen.route);
                                      }
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: 20.h),
                              CustomAuthButton(
                                text: "Continue with Facebook",
                                icon: AppIcons.facebook,
                                onTap: () async {
                                  await _auth
                                      .signInWithFacebook(context)
                                      .then((result) {
                                    if (result == null) {
                                      return;
                                    } else {
                                      Navigator.of(context)
                                          .pushNamed(HomeScreen.route);
                                    }
                                  });
                                },
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don’t have an account? ",
                                    style: TextStyle(
                                      color: AppColors.grey700,
                                      fontSize: 14.spMin,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(SignupScreen.route);
                                    },
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: AppColors.blue,
                                        fontSize: 14.spMin,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ! Back Button
            SafeArea(
              minimum: EdgeInsets.only(left: 30.w, top: 20.h),
              child: Visibility(
                visible: widget.showBackButton,
                child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AppBackButton(isCircular: true)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
