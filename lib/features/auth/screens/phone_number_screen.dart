import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/auth/providers/auth_provider.dart';
import 'package:applematch/features/auth/screens/verification_screen.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneNumberScreen extends ConsumerStatefulWidget {
  static const String route = '/phone_number_screen';
  const PhoneNumberScreen({super.key});

  @override
  ConsumerState<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends ConsumerState<PhoneNumberScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? selectedCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.pink50,
      ),
    );
    final _auth = ref.watch(authenticationProvider);

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login Your Account",
                          style: TextStyle(
                            fontSize: 30.spMin,
                            fontWeight: FontWeight.w600,
                            color: AppColors.pink500,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        IntlPhoneField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null) {
                              return 'Phone number required';
                            }

                            return null;
                          },
                          onChanged: (value) {
                            print(value.completeNumber);
                            ref.read(phoneNumberProvider.notifier).state =
                                value.completeNumber;
                            selectedCode = value.countryCode;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.84.r),
                            ),
                            hintText: "Enter Your Phonr Number",
                            hintStyle: TextStyle(
                              fontSize: 14.spMin,
                              fontWeight: FontWeight.w500,
                              color: AppColors.grey400,
                            ),
                            fillColor: Colors.white.withOpacity(0.67),
                            filled: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 14.h,
                              ),
                              child: SvgPicture.asset(
                                AppIcons.phone,
                                color: AppColors.grey400,
                              ),
                            ),
                          ),
                          initialCountryCode: 'US',
                        ),
                        SizedBox(height: 40.h),
                        PrimaryButton(
                          text: "Send verification",
                          onTap: () async {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                              print(_phoneNumberController.text);
                              await _auth
                                  .verifyPhoneNumber(context,
                                      "$selectedCode ${_phoneNumberController.text}")
                                  .then((result) {
                                if (result == null) {
                                  return;
                                } else {}
                              });
                            // Navigator.of(context)
                            //     .push(MaterialPageRoute(builder: (context) {
                            //   return VerificationScreen(verificationId: "");
                            // }));
                          },
                        )
                      ],
                    ),
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
