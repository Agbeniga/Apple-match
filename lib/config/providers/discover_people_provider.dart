import 'package:applematch/mock/mock_users.dart';
import 'package:applematch/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final discoverPeopleProvider = FutureProvider<List<User>>((ref) async {
  final users = mockUsers.getRange(0, 4).toList();
  final discoverNewUsers = await Future.delayed(
    const Duration(seconds: 1),
    () => users,
  );
  return discoverNewUsers;
});
