import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/config/utils/utils.dart';
import 'package:applematch/features/navigation/screens/bottom_navigation_screen.dart';
import 'package:applematch/features/payment/widgets/app_drop_down_button.dart';
import 'package:applematch/features/payment/widgets/card_text_field.dart';
import 'package:applematch/features/payment/widgets/mastercard.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddNewCardScreen extends StatefulWidget {
  static const String route = '/add-new-card';
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  late final TextEditingController _cardNumberController;
  late final TextEditingController _cardHolderController;
  late final TextEditingController _cvcController;
  late final FocusNode _cardNumberFocusNode;
  late final FocusNode _cardHolderFocusNode;
  late final FocusNode _cvcFocusNode;
  late final ScrollController _scrollController;

  bool isDefaultCard = true;
  final dates = List.generate(10, (index) => index + 1);
  final months = List.generate(12, (index) => index + 1);
  int expirationDay = 1;
  int expirationMonth = 1;

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _cardHolderController = TextEditingController();
    _cvcController = TextEditingController();
    _cardNumberFocusNode = FocusNode();
    _cardHolderFocusNode = FocusNode();
    _cvcFocusNode = FocusNode();
    _scrollController = ScrollController();

    _cardNumberFocusNode
        .addListener(() => _scrollToFocusedField(_cardNumberFocusNode));
    _cardHolderFocusNode
        .addListener(() => _scrollToFocusedField(_cardHolderFocusNode));
    _cvcFocusNode.addListener(() => _scrollToFocusedField(_cvcFocusNode));
  }

  @override
  void dispose() {
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _cvcController.dispose();
    _cardNumberFocusNode.dispose();
    _cardHolderFocusNode.dispose();
    _cvcFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToFocusedField(FocusNode focusNode) {
    if (focusNode.hasFocus) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.animateTo(
          _scrollController.position.pixels + 100.h,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(top: 72.h),
                  child: Column(
                    children: [
                      const MasterCard(),
                      SizedBox(height: 69.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 42.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Information",
                              style: TextStyle(
                                fontSize: 24.spMin,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10.h),

                            // ! card number field
                            TextFieldSection(
                              controller: _cardNumberController,
                              isCard: true,
                              title: "Card Number",
                              hintText: "5698    56254    6786    9979",
                              focusNode: _cardNumberFocusNode,
                              icon: Padding(
                                padding: EdgeInsets.only(right: 27.w),
                                child: Image.asset(
                                  AppImages.mastercard,
                                  height: 29.h,
                                  width: 29.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 29.h),

                            // ! card holder field
                            TextFieldSection(
                              controller: _cardHolderController,
                              title: "Card Holder",
                              hintText: 'Tom Hillson',
                              focusNode: _cardHolderFocusNode,
                            ),
                            SizedBox(height: 29.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ! expiration  date day
                                AppDropDownButton(
                                  items: dates,
                                  stateValue: expirationDay,
                                  itemHeight: 500.h,
                                  onChanged: (value) {
                                    setState(
                                      () => expirationDay = int.parse(
                                        value.toString(),
                                      ),
                                    );
                                  },
                                ),

                                // ! expiration date month
                                AppDropDownButton(
                                  items: months,
                                  stateValue: expirationMonth,
                                  itemHeight: 500.h,
                                  onChanged: (value) {
                                    setState(
                                      () => expirationMonth = int.parse(
                                        value.toString(),
                                      ),
                                    );
                                  },
                                ),

                                // ! cvc field
                                SizedBox(
                                  width: 103.w,
                                  height: 40.w,
                                  child: TextFormField(
                                    controller: _cvcController,
                                    cursorColor: AppColors.pink500,
                                    style: TextStyle(
                                      fontSize: 14.spMin,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black300,
                                    ),
                                    focusNode: _cvcFocusNode,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3),
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                        horizontal: 19.w,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: AppColors.black300,
                                            width: 1.5),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: AppColors.black300,
                                            width: 1.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: AppColors.black300,
                                            width: 1.5),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.5),
                                      ),
                                      hintText: "123",
                                      hintStyle: TextStyle(
                                        fontSize: 14.spMin,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.grey400,
                                      ),
                                      suffixIcon: Icon(
                                        FontAwesomeIcons.solidCircleQuestion,
                                        size: 14.spMin,
                                        color:
                                            const Color(0xFF004852).withOpacity(
                                          0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 33.h),
                            Row(
                              children: [
                                FlutterSwitch(
                                  value: isDefaultCard,
                                  onToggle: (value) {
                                    setState(() => isDefaultCard = value);
                                  },
                                  width: 46.w,
                                  height: 26.h,
                                  activeColor: AppColors.purple500,
                                  toggleSize: 18.sp,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Mark as default card",
                                  style: TextStyle(
                                    fontSize: 12.spMin,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFAAAAAA),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).center(),
              ),
            ),

            // ! title
            Positioned(
              top: 00.h,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 5.h),
                height: 110.h,
                alignment: Alignment.bottomCenter,
                color: Colors.white,
                child: Text(
                  "Add New Card",
                  style: TextStyle(
                    fontSize: 22.spMin,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            // ! back button
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: const SafeArea(child: AppBackButton()),
            ),

            // ! primary button
            Padding(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                bottom: 30.h,
              ),
              child: SafeArea(
                top: false,
                child: PrimaryButton(
                  text: "Confirm",
                  onTap: () {
// var da =List.generate(10, (index) => index + 24);
// print(da);
                    if (_cardNumberController.text.isEmpty ||
                        _cardHolderController.text.isEmpty ||
                        _cvcController.text.isEmpty) {
                      showError(context: context, text: "Fill in all inputs");
                      return;
                    }
                    Future.delayed(Duration(seconds: 5), (){
Navigator.pushNamedAndRemoveUntil(
                      context,
                      BottomNavigationScreen.route,
                      (route) => false,
                    );
                    });
                    
                    // Your confirm button action here
                  },
                ).bottom(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
