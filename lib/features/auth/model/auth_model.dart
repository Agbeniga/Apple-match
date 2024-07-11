import 'package:applematch/config/utils/utils.dart';
import 'package:applematch/features/auth/screens/verification_screen.dart';
import 'package:applematch/features/survey/screens/your_interest_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  //check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

//  SigIn the user using Email and Password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("${e.code}");
      if (e.code == "invalid-credential") {
        showError(context: context, text: 'Invalid Email or password');
      } else {
        showError(context: context, text: '${e.message}');
      }
    } catch (e) {
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  // SignUp the user using Email and Password
  Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-exists") {
        showError(context: context, text: 'Email already exist');
      } else if (e.code == "invalid-password") {
        showError(context: context, text: 'Invalid password');
      } else {
        showError(context: context, text: '${e.message}');
      }
    } catch (e) {
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
    return null;
  }

  Future<ConfirmationResult?> signInWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      return await _auth.signInWithPhoneNumber(phoneNumber);
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
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber.replaceAll(" ", "").trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // ANDROID ONLY!

          // Sign the user in (or link) with the auto-generated credential
          await _auth.signInWithCredential(credential);
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
          await _auth.signInWithCredential(credential);
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
  }

  //  SignIn the user Google
  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      showError(context: context, text: '${e.message}');
    } catch (e) {
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
  }

  //  SignIn the user Facebook
  Future<UserCredential?> signInWithFacebook(BuildContext context) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken == null) {
      return null;
    } // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    // Once signed in, return the UserCredential

    try {
      return await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      showError(context: context, text: '${e.message}');
    } catch (e) {
      showError(
          context: context, text: 'Something went wrong. Try again later');
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
