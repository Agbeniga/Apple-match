import 'package:applematch/mock/mock_posts.dart';
import 'package:applematch/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getAllPostProvider = FutureProvider<List<Post>>((ref) async {
  final posts = mockPosts;
  final allPosts = await Future.delayed(const Duration(seconds: 2), () {
    return posts;
  });
  return allPosts;
});
