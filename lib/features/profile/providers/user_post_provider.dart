import 'package:applematch/mock/mock_posts.dart';
import 'package:applematch/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userPostsProvider =
    FutureProvider.family<List<Post>, int>((ref, int userId) async {
  final posts = mockPosts
      .where(
        (post) => post.owner!.userId == userId,
      )
      .toList();
  final userPosts = await Future.delayed(const Duration(seconds: 1), () {
    return posts;
  });

  return userPosts;
});
