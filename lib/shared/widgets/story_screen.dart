import 'package:applematch/models/story.dart';
import 'package:applematch/shared/extensions/alignment.dart';
import 'package:applematch/shared/widgets/story_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryScreen extends StatefulWidget {
  final int index;
  final List<Story> stories;

  const StoryScreen({super.key, required this.stories, required this.index});

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  final TextEditingController _textController = TextEditingController();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.stories.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              StoryWidget(story: widget.stories[index]),
              textField(),
            ],
          );
        },
      ),
    );
  }

  textField() {
    return SafeArea(
      minimum: EdgeInsets.only(left: 24.w, right: 26.w, bottom: 12.h),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 53.h,
                    child: TextField(
                      controller: _textController,
                      onSubmitted: (String value) {},
                      style: TextStyle(
                        fontSize: 16.spMin,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(
                          15.w,
                          8.h,
                          15.w,
                          8.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.white,
                          ),
                        ),
                        hintText: "Your message",
                        hintStyle: TextStyle(
                          fontSize: 16.spMin,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 48.h,
                  width: 48.h,
                  margin: EdgeInsets.only(left: 14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      width: 2,
                      color: Colors.white,
                    ),
                  ),
                  child: Icon(
                    CupertinoIcons.paperplane,
                    size: 33.spMin,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ).bottom(),
      ),
    );
  }
}
