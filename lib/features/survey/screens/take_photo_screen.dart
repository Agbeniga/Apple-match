import 'dart:io';
import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/features/survey/providers/photo_provider.dart';
import 'package:applematch/features/survey/screens/add_photos_screen.dart';
import 'package:applematch/features/survey/screens/gallery_access_screen.dart';
import 'package:applematch/main.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/extensions/xfile_to_file_extension.dart';
import 'package:applematch/shared/widgets/back_button.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class TakePhotoScreen extends ConsumerStatefulWidget {
  static const String route = '/take-photo';
  const TakePhotoScreen({super.key});

  @override
  ConsumerState<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends ConsumerState<TakePhotoScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  File? imageFile;
  int _cameraIndex = 1;
  CameraController? _cameraController;
  late AnimationController _flashModeControlRowAnimationController;
  late AnimationController _exposureModeControlRowAnimationController;

  FlashMode flashMode = FlashMode.off;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _exposureModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
   
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameraIndex = 0; // Default to the first camera
    _cameraController = CameraController(
      cameras[_cameraIndex],
      ResolutionPreset.max,
    );
    await _cameraController?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  void switchCamera() async {
    if (cameras.length > 1) {
      CameraDescription newCamera;

      // Determine the new camera to switch to
      if (_cameraController?.description.lensDirection ==
          CameraLensDirection.front) {
        newCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back);
      } else {
        newCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front);
      }

      // Dispose of the current controller
      await _cameraController?.dispose();

      // Create and initialize a new controller
      _cameraController = CameraController(newCamera, ResolutionPreset.max);

      try {
        await _cameraController?.initialize();
      } catch (e) {
        print("Error initializing camera: $e");
      }

      // Update the UI
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _flashModeControlRowAnimationController.dispose();
    _exposureModeControlRowAnimationController.dispose();
    super.dispose();
    _cameraController?.dispose();
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = _cameraController;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file.file;
          ref.watch(takePhotoProvider.notifier).state = [
            ...ref.watch(takePhotoProvider),
            file.file!
          ]; // edit the state of the provider
          print(ref.watch(takePhotoProvider));
        });
        if (file != null) {
          // showInSnackBar('Picture saved to ${file.path}');
        }
      }
    });
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void onFlashModeButtonPressed() {
    setState(() {
      if (flashMode == FlashMode.off) {
        _cameraController?.setFlashMode(FlashMode.torch);
        flashMode = FlashMode.torch;
      } else {
        _cameraController?.setFlashMode(FlashMode.off);
        flashMode = FlashMode.off;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController == null ||
        _cameraController?.value.isInitialized == false) {
      return Container();
    }
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: const SafeArea(child: AppBackButton(isCircular: true)),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 66.h, left: 36.w, right: 36.w),
              child: Column(
                children: [
                  Text(
                    "Take Photo",
                    style: TextStyle(
                      fontSize: 32.spMin,
                      fontWeight: FontWeight.w500,
                      color: AppColors.pink500,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  if (imageFile == null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 500.h,
                        child: CameraPreview(_cameraController!),
                      ),
                    )
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(40.r),
                      child: SizedBox(
                        width: double.maxFinite,
                        height: 500.h,
                        child: Image.file(
                          imageFile!,
                          height: 500.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(height: 53.h),
                  imageFile == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 24.w),
                            InkWell(
                              onTap: (){
                                Navigator.of(context).pushNamed(GalleryAccessScreen.route);
                              },
                              child: const Icon(
                                IconlyLight.image,
                                color: AppColors.pink500,
                              ),
                            ),
                            SizedBox(width: 24.w),

                            // ! take picture button
                            InkWell(
                              borderRadius: BorderRadius.circular(999.9),
                              onTap: _cameraController != null &&
                                      _cameraController?.value.isInitialized ==
                                          true
                                  ? onTakePictureButtonPressed
                                  : null,
                              child: Ink(
                                height: 92.h,
                                width: 92.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999.9),
                                  color: AppColors.pink500,
                                ),
                                child: const Icon(
                                  IconsaxPlusBroken.camera,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            InkWell(
                              borderRadius: BorderRadius.circular(999.9),
                              onTap: _cameraController != null
                                  ? onFlashModeButtonPressed
                                  : null,
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                decoration: BoxDecoration(
                                  color: flashMode == FlashMode.torch
                                      ? Colors.grey.withOpacity(0.4)
                                      : Colors.transparent,
                                      shape: BoxShape.circle
                                ),
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16.sp,
                                  vertical: 12.sp,
                                ),
                                child: SvgPicture.asset(
                                  AppIcons.flashLight,
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            InkWell(
                              borderRadius: BorderRadius.circular(999.9),
                              onTap: switchCamera,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14.sp,
                                  vertical: 14.sp,
                                ),
                                child: SvgPicture.asset(AppIcons.swapCamera),
                              ),
                            ),
                          ],
                        )
                      : PrimaryButton(
                          height: 48.h,
                          width: 199.w,
                          text: "Proceed",
                          onTap: () => Navigator.popUntil(
                            context,
                            (route) =>
                                route.settings.name == AddPhotoScreen.route,
                          ),
                        ),
                ],
              ),
            ),
          ).center()
        ],
      ),
    );
  }
}


void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}
