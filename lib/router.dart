import 'package:applematch/features/auth/screens/forgot_password_screen.dart';
import 'package:applematch/features/auth/screens/login_screen.dart';
import 'package:applematch/features/auth/screens/login_signup_screen.dart';
import 'package:applematch/features/auth/screens/phone_number_screen.dart';
import 'package:applematch/features/auth/screens/signup_screen.dart';
import 'package:applematch/features/auth/screens/verification_screen.dart';
import 'package:applematch/features/auth/screens/verify_email_screen.dart';
import 'package:applematch/features/bot/screens/apple_genie_screen.dart';
import 'package:applematch/features/discover/screens/discover_screen.dart';
import 'package:applematch/features/genie_onboarding/genie_onboarding_screen.dart';
import 'package:applematch/features/home/screens/home_screen.dart';
import 'package:applematch/features/matches/screens/matches_screen.dart';
import 'package:applematch/features/messages/screens/message_screen.dart';
import 'package:applematch/features/navigation/screens/bottom_navigation_screen.dart';
import 'package:applematch/features/notification/screens/notification_screen.dart';
import 'package:applematch/features/onboarding/screens/onboarding_screen.dart';
import 'package:applematch/features/payment/screens/add_new_card_screen.dart';
import 'package:applematch/features/payment/screens/payment_wall_screen.dart';
import 'package:applematch/features/profile/screens/account_screen.dart';
import 'package:applematch/features/profile/screens/edit_profile_screen.dart';
import 'package:applematch/features/profile/screens/profile_screen.dart';
import 'package:applematch/features/splash/splash_screen.dart';
import 'package:applematch/features/survey/screens/add_photos_screen.dart';
import 'package:applematch/features/survey/screens/age_screen.dart';
import 'package:applematch/features/survey/screens/gallery_access_screen.dart';
import 'package:applematch/features/survey/screens/gender_select_screen.dart';
import 'package:applematch/features/survey/screens/looking_for_screen.dart';
import 'package:applematch/features/survey/screens/photo_verification_screen.dart';
import 'package:applematch/features/survey/screens/take_photo_screen.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SplashScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case OnboardingScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OnboardingScreen(),
      );

    case LoginSignupScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginSignupScreen(),
      );
    case SignupScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );
    case LoginScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );
    case ForgotPasswordScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ForgotPasswordScreen(),
      );
    case PhoneNumberScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PhoneNumberScreen(),
      );

    case VerifyEmailScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VerifyEmailScreen(),
      );
    case YourInterestScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const YourInterestScreen(),
      );
    case BottomNavigationScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavigationScreen(),
      );
    case AddPhotoScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddPhotoScreen(),
      );
    case PhotoVerificationScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PhotoVerificationScreen(),
      );
    case TakePhotoScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const TakePhotoScreen(),
      );
    case GalleryAccessScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const GalleryAccessScreen(),
      );
    case GenderSelectScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const GenderSelectScreen(),
      );
    case LookingForScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LookingForScreen(),
      );

    case PaymentWallScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PaymentWallScreen(),
      );

    case AddNewCardScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddNewCardScreen(),
      );

    case HomeScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case DiscoverScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DiscoverScreen(),
      );
    case MatchesScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MatchesScreen(),
      );

    case ProfileScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
      );
    case MessageScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MessageScreen(),
      );

    case NotificationScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationScreen(),
      );

    case AccountScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AccountScreen(),
      );

    case EditProfileSCreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EditProfileSCreen(),
      );
    case AgeScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AgeScreen(),
      );
    case AppleGenieScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AppleGenieScreen(),
      );

    case GenieOnboardingScreen.route:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const GenieOnboardingScreen(),
      );

    default:
      print(routeSettings.name);
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
  }
}
