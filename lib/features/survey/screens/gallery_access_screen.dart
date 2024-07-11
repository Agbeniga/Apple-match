import 'dart:io';

import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/features/survey/providers/photo_provider.dart';
import 'package:applematch/features/survey/screens/add_photos_screen.dart';
import 'package:applematch/features/survey/screens/photo_album_screen.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryAccessScreen extends ConsumerStatefulWidget {
  static const String route = '/galleryaccess';
  const GalleryAccessScreen({super.key});

  @override
  ConsumerState<GalleryAccessScreen> createState() =>
      _GalleryAccessScreenState();
}

class _GalleryAccessScreenState extends ConsumerState<GalleryAccessScreen> {
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 66.h, left: 24.w, right: 24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(AppImages.galleryAccess),
                  SizedBox(height: 45.h),
                  Text(
                    "Activate access to gallery",
                    style: TextStyle(
                      color: AppColors.pink500,
                      fontSize: 29.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    width: 380.w,
                    height: 72.h,
                    child: Text(
                      "You can use photos from your gallery to upload personal photos and documents for verification of your profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.grey700,
                        fontSize: 16.spMin,
                      ),
                    ),
                  ),
                  SizedBox(height: 61.h),
                  PrimaryButton(
                    text: "Next",
                    onTap: () async {
                      try {
                        final PermissionState ps = await PhotoManager
                            .requestPermissionExtend(); // the method can use optional param `permission`.

                        if (ps.isAuth) {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return PhotoAlbumScreen();
                          //     },
                          //   ),
                          // );
                          // Pick an image.
                          await pickImage();
                        } else if (ps.hasAccess) {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return PhotoAlbumScreen();
                          //     },
                          //   ),
                          // );
                          await pickImage();
                        } else {
                          await PhotoManager.requestPermissionExtend();
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ],
              ),
            ),
          ).center(),
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: const SafeArea(child: AppBackButton(isCircular: true)),
          ),
        ],
      ),
    );
  }

  Future pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    File? filePath = File(image!.path);
    ref.watch(takePhotoProvider.notifier).state = [
      ...ref.watch(takePhotoProvider),
      filePath
    ]; // edit the state of the provider

    Navigator.pushReplacementNamed(context, AddPhotoScreen.route);
  }
}
