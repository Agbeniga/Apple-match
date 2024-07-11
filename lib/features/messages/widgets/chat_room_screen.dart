import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/call/screens/phone_call_screen.dart';
// import 'package:applematch/features/survey/providers/photo_provider.dart';
import 'package:applematch/features/survey/screens/take_photo_screen.dart';
import 'package:applematch/models/user_model.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatRoomScreen extends ConsumerStatefulWidget {
  static const String route = '/chat-room';

  final User user;

  const ChatRoomScreen({super.key, required this.user});

  @override
  ConsumerState<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends ConsumerState<ChatRoomScreen> {
  final FocusNode _focusNode = FocusNode();
  bool _isTextFieldFocused = false;
  late final TextEditingController _controller;
  List<String> messages = [];

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

  @override
  Widget build(BuildContext context) {
    // final photos = ref.watch(takePhotoProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFEFEFE),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              const AppBackButton(isCircular: true),
              SizedBox(width: 16.5.w),
              Row(
                children: [
                  Stack(
                    children: [
                      // ! profile picture
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.user.imageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator.adaptive(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          height: 44.h,
                          width: 44.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 5.h,
                        right: 0.w,
                        child: Container(
                          height: 8.h,
                          width: 8.h,
                          decoration: BoxDecoration(
                            color: AppColors.green200,
                            borderRadius: BorderRadius.circular(99.r),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(width: 10.5.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ! user name
                      Text(
                        widget.user.username!,
                        style: TextStyle(
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000E08),
                        ),
                      ),

                      // ! widget to display if user if active
                      Text(
                        "Active now",
                        style: TextStyle(
                          fontSize: 12.spMin,
                          color: const Color(0xFF797C7B).withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  // call button
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhoneCallScreen(user: widget.user),
                      ),
                    ),
                    child: SvgPicture.asset(AppIcons.phone),
                  ),

                  SizedBox(width: 13.5.w),

                  // video button
                  SvgPicture.asset(AppIcons.video),
                ],
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            // ! text field and action buttons
            textFieldArea().bottom(),
            Positioned(
              top: 20.h,
              left: 0,
              right: 0,
              child: infoContainer(text: 'Today').center(),
            ),
            Positioned(
              top: 56.h,
              left: 0,
              right: 0,
              child: infoContainer(
                text:
                    'Messages and calls are end-to-end\n encrypted. Apple Genie provides\n compatibility insight during live chats.\n \nDo well to bring an apple to your first date.',
                weight: FontWeight.w300,
              ).center(),
            )
          ],
        ),
      ),
    );
  }

  Widget infoContainer({
    String text = '',
    EdgeInsets? padding,
    Widget? child,
    FontWeight? weight,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.fromLTRB(9.18.w, 5.h, 10.71.w, 5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: AppColors.pink500.withOpacity(0.1),
      ),
      child: child ??
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xFF000E08),
              fontSize: 12.spMin,
              fontWeight: weight ?? FontWeight.w500,
            ),
          ),
    );
  }

  Widget textFieldArea() {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 9.h, 12.w, 30.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEEFAF8),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 13.11.w),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(AppIcons.clip),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 40.h,
              padding: EdgeInsets.fromLTRB(15.02.w, 0.h, 12.94.w, 0.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: const Color(0xFFF3F6F6),
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
                        fontSize: 12.spMin,
                        color: AppColors.black100,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 12.h),
                        hintText: 'Drop your pickup line',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12.spMin,
                          color: AppColors.grey800.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(top: 9.h, bottom: 7.h),
                      child: Visibility(
                        visible: !_isTextFieldFocused,
                        child: InkWell(
                          onTap: () {},
                          child: Image.asset(AppIcons.jasperAi),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18.85.w),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, TakePhotoScreen.route),
              child: SvgPicture.asset(AppIcons.openCamera),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 14.24.w),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(AppIcons.microphone),
            ),
          ),
        ],
      ),
    );
  }
}
