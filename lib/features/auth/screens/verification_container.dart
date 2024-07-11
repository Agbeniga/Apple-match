import 'dart:io';

import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/features/auth/providers/timer_provider.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

class VerificationContainer extends ConsumerStatefulWidget {
  const VerificationContainer({super.key});

  @override
  ConsumerState<VerificationContainer> createState() =>
      _VerificationContainerState();
}

class _VerificationContainerState extends ConsumerState<VerificationContainer> {
 
    SmsRetriever? smsRetriever;
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
        formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();

if(Platform.isAndroid){
    /// In case you need an SMS autofill feature
    smsRetriever = SmsRetrieverImpl(
      SmartAuth(),
    );
    }
  }

   var focusedBorderColor = AppColors.black100;
    var fillColor = Colors.transparent;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.grey400),
      ),
    );

  @override
  void dispose() {
   pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(timerProvider);
    // final phoneNumber = ref.watch(phoneNumberProvider);
    // final _auth = ref.watch(authenticationProvider);

    return Container(
      padding: EdgeInsets.only(
        top: 40.h,
        bottom: 42.h,
        left: 17.5,
        right: 17.5,
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(27.r),
        color: const Color(0xFFF7F8FA),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 13.32),
            blurRadius: 55.48,
            color: AppColors.purple600.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Verify Phone Number",
            style: TextStyle(
              fontSize: 22.spMin,
              fontWeight: FontWeight.w600,
              color: AppColors.pink500,
            ),
          ),
          SizedBox(height: 11.h),
          Text(
            "We Have Sent Code To Your Phone Number",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.spMin,
              color: AppColors.grey500,
            ),
          ).center(),
          SizedBox(height: 39.h),
          // Text(
          //   // TODO: SHOULD BE THE PERSON'S NUMBER
          //   "$phoneNumber",
          //   style: TextStyle(
          //     fontSize: 14.spMin,
          //     fontWeight: FontWeight.w600,
          //     color: AppColors.grey500,
          //   ),
          // ),
          SizedBox(height: 29.h),
          Form(
             key: formKey,
            child:  Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              // You can pass your own SmsRetriever implementation based on any package
              // in this example we are using the SmartAuth
              smsRetriever: smsRetriever,
              controller: pinController,
              focusNode: focusNode,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              validator: (value) {
                return value == '2222' ? null : 'Pin is incorrect';
              },
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          ),
          SizedBox(height: 9.h),
          Text(
            '($timer)',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.spMin,
              color: AppColors.grey500,
            ),
          ).left(),
          SizedBox(height: 29.23.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryButton(
                text: "Verify",
                height: 68.21.h,
                onTap: () async {
                  Navigator.pushNamed(context, YourInterestScreen.route);
                },
              ),
              const SizedBox(height: 12.4),
              PrimaryButton(
                text: "Send Again",
                color: AppColors.grey50,
                textColor: timer != "00:00"
                    ? const Color(0xFFCBCBCB)
                    : AppColors.grey600,
                height: 68.21.h,
                onTap: () async {
                  if (timer != "00:00") {
                    print("it's not done");

                    // await _auth
                    //     .verifyPhoneNumber(context, phoneNumber!)
                    //     .then((result) {
                    //   if (result == null) {
                    //     return;
                    //   } else {
                    //     Navigator.of(context)
                    //         .pushNamed(YourInterestScreen.route);
                    //   }
                    // });
                  } else {
                    print("it's done");
                    ref.watch(timerProvider.notifier).resetTimer();
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SmsRetrieverImpl implements SmsRetriever {
  const SmsRetrieverImpl(this.smartAuth);

  final SmartAuth smartAuth;

  @override
  Future<void> dispose() {
    return smartAuth.removeSmsListener();
  }

  @override
  Future<String?> getSmsCode() async {
    final signature = await smartAuth.getAppSignature();
    debugPrint('App Signature: $signature');
    final res = await smartAuth.getSmsCode(
      useUserConsentApi: true,
    );
    if (res.succeed && res.codeFound) {
      return res.code!;
    }
    return null;
  }

  @override
  bool get listenForMultipleSms => false;
}