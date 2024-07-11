import 'package:applematch/mock/mock_stories.dart';
import 'package:applematch/models/story.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyProvider = FutureProvider<List<Story>>((ref) async {
  final stories = await Future.delayed(3.seconds, () => mockStory);
  return stories;
});
