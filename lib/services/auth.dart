import 'package:applematch/config/preference/preference_manager.dart';
import 'package:applematch/config/utils/utils.dart';
import 'package:applematch/features/auth/screens/verification_screen.dart';
import 'package:applematch/models/user_data.dart';
import 'package:applematch/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authServiceProvider = ChangeNotifierProvider<AuthService>((ref) {
  return AuthService();
});

class AuthService extends ChangeNotifier {
  bool isLoading = false;
  FirebaseAuth authInstance = FirebaseAuth.instance;

  AuthRepository authRepository = AuthRepository(auth: FirebaseAuth.instance);

  Future<UserData?> getUserData() async {
    UserData? user = await authRepository.getCurrentUserData();
    return user;
  }

  Future<UserCredential?> signInWithGoogle() async {
    _setLoading(true);
    // Trigger the authentication flow
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      _setLoading(false);
      return null;
    }

    // Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken!,
      idToken: googleAuth.idToken!,
    );

    // Once signed in, return the UserCredential
    final userCredential = await authInstance.signInWithCredential(credential);
    await authRepository.addUser(userCredential.user!);
    _setLoading(false);
    return userCredential;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    _setLoading(true);
    try {
      final userCredential = await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _setLoading(false);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      print("Error => $e");
      if (e.code == "invalid-credential") {
        showError(context: context, text: 'Invalid Email or password');
      } else if (e.code == 'user-not-found') {
        showError(context: context, text: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showError(
            context: context, text: 'Wrong password provided for that user.');
      } else {
        showError(context: context, text: '${e.message}');
      }
      return null;
    }
  }

  Future<UserCredential?> registerWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    _setLoading(true);
    try {
      final userCredential = await authInstance.createUserWithEmailAndPassword(
        email: email,
        password: email,
      );
      await authRepository.addUser(userCredential.user!);
      _setLoading(false);
      return userCredential;
    } on FirebaseAuthException catch (error) {
      _setLoading(false);
      if (error.code == "email-already-exists") {
        showError(context: context, text: 'Email already exist');
      } else if (error.code == "invalid-password") {
        showError(context: context, text: 'Invalid password');
      } else {
        showError(context: context, text: '${error.message}');
      }
      print(error.toString());
      print(error.code);
    } catch (e) {
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  Future<ConfirmationResult?> signInWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      final userCredential =
          await authInstance.signInWithPhoneNumber(phoneNumber);

      _setLoading(false);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == "phone-number-already-exists") {
        showError(context: context, text: 'Phone number already exist');
      } else if (e.code == "invalid-phone-number") {
        showError(context: context, text: 'Invalid phone number');
      } else {
        showError(context: context, text: '${e.message}');
      }
    } catch (e) {
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  Future<UserCredential?> verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      print("Phone number auth ${phoneNumber.replaceAll(" ", "")}");
      await authInstance.verifyPhoneNumber(
        phoneNumber: phoneNumber.replaceAll(" ", "").trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await authInstance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            showError(context: context, text: 'Invalid phone number');
          }

          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = 'xxxx';
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return VerificationScreen(verificationId: verificationId);
          }));

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await authInstance.signInWithCredential(credential);
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        },
      );
    } on FirebaseAuthException catch (e) {
      showError(context: context, text: '${e.message}');
    } catch (e) {
      print(e);
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  //  SignIn the user Facebook
  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    _setLoading(true);
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      return null;
    } // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential

    try {
      final userCredential =
          await authInstance.signInWithCredential(facebookAuthCredential);
      await authRepository.addUser(userCredential.user!);
      _setLoading(false);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      showError(context: context, text: '${e.message}');
    } catch (e) {
      _setLoading(false);
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  Future resetPassword(
      {required String email, required BuildContext context}) async {
    try {
      await authInstance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      showError(context: context, text: '${e.message}');
    } catch (e) {
      _setLoading(false);
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  Future<void> signOut() async {
    await authInstance.signOut();
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }

    await FacebookAuth.instance.logOut();
    PreferenceManager.clear();
  }

  void _setLoading(bool newValue) {
    isLoading = newValue;
    notifyListeners();
  }
}
