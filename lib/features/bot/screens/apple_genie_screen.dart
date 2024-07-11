import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'dart:math' as math;

class AppleGenieScreen extends StatefulWidget {
  static const String route = '/apple-genie';

  const AppleGenieScreen({super.key});

  @override
  State<AppleGenieScreen> createState() => _AppleGenieScreenState();
}

class _AppleGenieScreenState extends State<AppleGenieScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isTextFieldFocused = false;
  late final TextEditingController _controller;
  List<String> messages = [
    // 'What can i do to Impress Sarah ',
    // "To capture Sarah's attention and admiration, engage in laid-back conversations where you express sincere interest in her passion for dance and drama. Take the time to listen attentively as she shares her experiences and insights, showing genuine appreciation for her unique perspective. Offer compliments that reflect your genuine admiration for her talents and personality, creating a warm and friendly atmosphere. Become her supportive companion,"
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _controller = TextEditingController();
  }

  void _onFocusChange() {
    setState(() {
      _isTextFieldFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
  }

  void sendMessage() {
    setState(() {
      messages.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppBackButton(isCircular: true),
              Text(
                "Apple Genie",
                style: TextStyle(
                  color: AppColors.black300,
                  fontSize: 22.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(99.9.r),
                onTap: () {},
                child: Ink(
                  padding: EdgeInsets.all(10.spMin),
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.purple500.withOpacity(0.2),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(99.9.r),
                  ),

                  // ! check if any notification is available
                  child: SvgPicture.asset(AppIcons.moreHorizOutlined),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Visibility(
              visible: messages.isEmpty,
              child: Positioned(
                top: 40.h,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 41.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'AppleGenie',
                        style: TextStyle(
                          color: const Color(0xFF757474),
                          fontSize: 40.spMin,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 51.h),
                      infoContainer(
                        'Remembers what user said\n earlier in the conversation',
                      ),
                      SizedBox(height: 11.97.h),
                      infoContainer(
                        'Allows user to provide.\nfollow-up corrections With Ai',
                      ),
                      SizedBox(height: 11.97.h),
                      infoContainer(
                        'Limited knowledge of Potential Partners',
                      ),
                      SizedBox(height: 35.37.h),
                      infoContainer(
                        'May occasionally generate\nincorrect information',
                      ),
                      SizedBox(height: 12.77.h),
                      infoContainer(
                        'May occasionally produce harmful\n instructions or biased content',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 18.h, bottom: 50.h),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if (index.isEven) {
                    return userMessageContainer(messages[index]);
                  } else {
                    return aiMessageContainer(messages[index]);
                  }
                },
              ),
            ),
            // ! text field and action buttons
            textFieldArea().bottom(),
          ],
        ),
      ),
    );
  }

  userMessageContainer(message) {
    return Container(
      margin: EdgeInsets.only(bottom: 21.h),
      padding: EdgeInsets.fromLTRB(35.w, 0, 35.w, 0),
      child: Row(
        children: [
          // ! user profile picture
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: CachedNetworkImage(
              imageUrl:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSeJmFW_rzPyuJUmTEmTk9ZLB7u1CmTclyKCA&s',
              errorWidget: (context, url, error) => const Icon(Icons.error),
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
              height: 37.h,
              width: 37.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 17.w),

          // ! message
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2F2F2F),
              fontSize: 11.82.spMin,
              letterSpacing: 0.15,
            ),
          ),
          const Spacer(),
          // ! edit button
          InkWell(
            borderRadius: BorderRadius.circular(99.r),
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: SvgPicture.asset(AppIcons.edit),
            ),
          )
        ],
      ),
    );
  }

  Widget aiMessageContainer(String aiResponse) {
    return Padding(
      padding: EdgeInsets.only(bottom: 23.h),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 35.w),
            decoration: const BoxDecoration(
              color: AppColors.pink50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.aiProfile,
                  height: 38.h,
                ),
                SizedBox(height: 10.65.h),
                Text(
                  aiResponse,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF494949),
                    fontSize: 11.82.spMin,
                    letterSpacing: 0.15,
                  ),
                )
              ],
            ),
          ),
          // ! regenerate button
          Visibility(
            // only visible if there was an error in sending response

            visible: false,
            child: Column(
              children: [
                SizedBox(height: 80.48.h),
                Container(
                  padding: EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h,
                    left: 9.w,
                    right: 11.53.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.65.r),
                    border: Border.all(
                      color: const Color(0xFFCCCCCC),
                      width: 1.44,
                    ),
                    color: const Color(0xFFFAFAFA),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppIcons.regenerate),
                      SizedBox(width: 8.65.w),
                      Text(
                        "Regenerate Response",
                        style: GoogleFonts.urbanist(
                          fontSize: 12.97.spMin,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF616161),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoContainer(String text) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(18.2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.49.r),
        color: AppColors.pink500.withOpacity(0.1),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: const Color(0xFFA0A0A5),
          fontSize: 14.49.spMin,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget textFieldArea() {
    return Container(
      padding: EdgeInsets.fromLTRB(43.w, 9.h, 42.w, 30.h),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 48.h,
              padding: EdgeInsets.fromLTRB(15.02.w, 0.h, 12.94.w, 0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFE1E1E1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      cursorColor: AppColors.pink500,
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: AppColors.black100,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 8.h),
                        hintText: 'Send a message',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 16.spMin,
                          color: AppColors.grey800.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: sendMessage,
                    child: Padding(
                      padding: EdgeInsets.only(top: 9.h, bottom: 7.h),
                      child: Transform.rotate(
                        angle: 45 * (math.pi / 180),
                        child: const Icon(
                          IconlyBold.send,
                          color: AppColors.pink500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: messages.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(12.spMin),
                  height: 48.h,
                  width: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99.r),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFC2C3CB),
                      width: 1.0,
                    ),
                  ),
                  child: SvgPicture.asset(AppIcons.microphoneFilled),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
