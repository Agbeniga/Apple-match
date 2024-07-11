import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/constants/payment_tier_constants.dart';
import 'package:applematch/config/images/app_images.dart';
import 'package:applematch/features/payment/providers/payment_tier_provider.dart';
import 'package:applematch/features/payment/screens/add_new_card_screen.dart';
import 'package:applematch/features/payment/widgets/payment_tier_container.dart';
import 'package:applematch/features/payment/widgets/step_widget.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentWallScreen extends ConsumerStatefulWidget {
  static const String route = '/payment-wall';
  const PaymentWallScreen({super.key});

  @override
  ConsumerState<PaymentWallScreen> createState() => _PaymentWallScreenState();
}

class _PaymentWallScreenState extends ConsumerState<PaymentWallScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToItem(int index) {
    final itemWidth = 195.w; // width of each item
    final padding = 13.w; // padding on either side
    final screenWidth = MediaQuery.of(context).size.width;

    // calculate the target position to center the item
    final targetPosition =
        (itemWidth * index) - (screenWidth / 2 - itemWidth / 2) + padding;

    _scrollController.animateTo(
      targetPosition,
      duration: 300.ms,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTier = ref.watch(paymentTierProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ! background image
          Image.asset(
            AppImages.premiumImage,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),

          // ! payment info
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, left: 19.w, right: 19.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Try for Free',
                    style: TextStyle(
                      fontSize: 36.spMin,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'How it Works',
                    style: TextStyle(
                      fontSize: 20.spMin,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  StepWidget(
                    icon: CupertinoIcons.lock_open_fill,
                    color: const Color(0xFFDF3170),
                    title: 'Today: Get 10 Free Trial Apples',
                    description:
                        'Get free trial apples for 3 days after completing 90% of your Profile',
                  ),
                  StepWidget(
                    icon: CupertinoIcons.bell_fill,
                    color: const Color(0xFF2C2C2E),
                    title: 'Day 2: Trial Reminder',
                    description:
                        'Get reminder about when your free trial will end',
                  ),
                  StepWidget(
                    icon: CupertinoIcons.wand_stars,
                    color: const Color(0xFF2C2C2E),
                    title: 'Day 3: Trial Ends',
                    description:
                        'Trial apples get rotten. Select a Subscription plan to get more apples',
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 439.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF666666).withOpacity(0.0),
                  const Color(0xFF000000).withOpacity(0.7),
                  const Color(0xFF000000).withOpacity(1.0),
                  const Color(0xFF000000).withOpacity(1.0),
                ],
              ),
            ),
          ).bottom(),

          // ! payment tiers
          Positioned(
            left: 0,
            right: 0,
            bottom: 183.h,
            child: SafeArea(
              top: false,
              child: SizedBox(
                height: 260.h,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentTierConstants.length,
                  itemBuilder: (context, index) {
                    final currentPaymentTier = paymentTierConstants[index];
                    return PaymentTierContainer(
                      tier: currentPaymentTier,
                      isSelected: currentPaymentTier == selectedTier,
                      onTap: () {
                        ref.read(paymentTierProvider.notifier).state =
                            currentPaymentTier;
                        _scrollToItem(index);
                      },
                    );
                  },
                ),
              ),
            ),
          ),

          // MARK: PAYMENT BUTTON
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.h, left: 47.w, right: 47.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "3-day free trial, then \$${selectedTier.price}month",
                    style: GoogleFonts.nunito(
                      textStyle: TextStyle(
                        fontSize: 15.spMin,
                        color: const Color(0xFF3C3C43),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ! Button
                  PrimaryButton(
                    text: "Subscribe for \$${selectedTier.price}/month",
                    height: 64.h,
                    borderRadius: 99.9.r,
                    fontSize: 17.spMin,
                    color: const Color(0xFFC92560),
                    onTap: () {
                      Navigator.pushNamed(context, AddNewCardScreen.route);
                    },
                  ),
                  SizedBox(height: 8.h),

                  // ! terms of use
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Restore Purchase",
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 12.spMin,
                                color: AppColors.blue200,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Terms of use",
                            style: GoogleFonts.nunito(
                              textStyle: TextStyle(
                                fontSize: 12.spMin,
                                color: AppColors.blue200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ).bottom(),
            ),
          ),
        ],
      ),
    );
  }
}
