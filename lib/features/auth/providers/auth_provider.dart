import 'package:applematch/features/auth/model/auth_model.dart';
import 'package:applematch/models/user_data.dart';
import 'package:applematch/services/auth.dart';
import 'package:applematch/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});

final authStateProvider = StreamProvider.autoDispose<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final authControllerProvider = Provider((ref) {
  return AuthRepository(auth: FirebaseAuth.instance);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authServiceProvider);
  return authController.getUserData();
});

final loadingProvider = StateProvider<bool>((ref) => false);

final phoneNumberProvider = StateProvider<String?>((ref) => null);

final nameErrorProvider = StateProvider<String?>((ref) => null);

final phoneNumberErrorProvider = StateProvider<String?>((ref) => null);

final emailErrorProvider = StateProvider<String?>((ref) => null);

final passwordErrorProvider = StateProvider<String?>((ref) => null);

final userDataStreamProvider =
    StreamProvider.autoDispose<UserData?>((ref) async* {
  final user =
      ref.read(authStateProvider).value ?? FirebaseAuth.instance.currentUser;

  print("======== User ========== ${user?.uid}");
  if (user == null) {
    yield null;
  } else {
    AuthRepository _authRepository =
        AuthRepository(auth: FirebaseAuth.instance);
    final dataStream = _authRepository.userDataStream(user.uid);
    print("======== User Data stream ==========");
    // Yield values from dataStream
    await for (final data in dataStream) {
      print("======== User Data AH ========== ${data?.uid}");
      yield data;
    }
    yield* dataStream;
  }
});
