import 'package:animations/animations.dart';
import 'package:applematch/models/story.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story_view/story_view.dart';

class StoryWidget extends StatefulWidget {
  final Story story;

  const StoryWidget({super.key, required this.story});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textController = TextEditingController();
  final StoryController _controller = StoryController();

  List<StoryItem> story() {
    final stories = List.generate(
      widget.story.storyUrls!.length,
      (itemIndex) {
        final url = widget.story.storyUrls![itemIndex];
        return StoryItem.pageImage(
          url: url,
          controller: _controller,
          imageFit: BoxFit.cover,
        );
      },
    );
    return stories;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _textController.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Stack(
        children: [
          OpenContainer(
            transitionType: ContainerTransitionType.fade,
            closedBuilder: (context, action) {
              return StoryView(
                storyItems: story(),
                controller: _controller,
                repeat: true, // should the stories be slid forever
                onStoryShow: (s, index) {},
                onComplete: () {},
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    Navigator.pop(context);
                  }
                }, // To disable vertical swipe gestures, ignore this parameter.
                // Preferrably for inline story view.
                indicatorHeight: IndicatorHeight.small,
              );
            },
            openBuilder: (context, action) {
              return StoryView(
                storyItems: story(),
                controller: _controller,
                repeat: true, // should the stories be slid forever
                onStoryShow: (s, index) {},
                onComplete: () {},
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.down) {
                    Navigator.pop(context);
                  }
                }, // To disable vertical swipe gestures, ignore this parameter.
                // Preferrably for inline story view.
                indicatorHeight: IndicatorHeight.small,
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 25.h, left: 13.w, right: 17.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99.9.r),
                        child: CachedNetworkImage(
                          imageUrl: widget.story.user!.imageUrl!,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator.adaptive(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          height: 60.h,
                          width: 60.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        widget.story.user!.username!,
                        style: TextStyle(
                          fontSize: 20.spMin,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  CupertinoButton(
                    onPressed: () {},
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.zero,
                    child: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                      size: 32.spMin,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
