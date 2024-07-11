import 'package:applematch/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  AuthRepository({
    required this.auth,
  });

Future<UserData?> getCurrentUserData() async {
  var userData =
      await usersRef.doc(FirebaseAuth.instance.currentUser?.uid).get();

  UserData? user;
  if (userData.data() != null) {
    user = UserData.fromMap(userData.data()!);
  }
  return user;
}

Future<void> addUser(User user) async {
  final documentSnapshot = await usersRef.doc(user.uid).get();
  if (!documentSnapshot.exists) {
    await usersRef.doc(user.uid).set(
      {
        'uid': user.uid,
        'photoURL': user.photoURL,
        'email': user.email,
        'displayName': user.displayName,
        'phoneNumber': user.phoneNumber,
      },
    );
  }
}

Future<UserData> getUserData(String uid) async {
  final documentSnapshot = await usersRef.doc(uid).get();
  return UserData.fromMap(documentSnapshot.data()!);
}

Stream<UserData?> userDataStream(String uid) async* {
  try {
    final docSnapshotStream = usersRef.doc(uid).snapshots();
    yield* docSnapshotStream.map(
      (ds) => UserData.fromMap(
        ds.data()!,
      ),
    );
  } catch (e) {
    print("========== Errorrr ===========");
    print(e);
    yield null;
  }
}

List<UserData> _userDataListFromQuerySnapshot(QuerySnapshot qs) {
  return qs.docs.map((ds) {
    return UserData.fromMap(ds.data()! as Map<String, dynamic>);
  }).toList();
}

Future<List<UserData>> listUsers() async {
  final usersQuerySnapshot = await usersRef.get();
  final userDataList = _userDataListFromQuerySnapshot(usersQuerySnapshot);
  return userDataList;
}
}