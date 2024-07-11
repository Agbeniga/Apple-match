import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionButton extends StatefulWidget {
  final List<String> options;
  const SelectionButton({super.key, required this.options});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.4.h),
              child: PrimaryButton(
                text: widget.options[index],
                height: 55.h,
                color: selected != index ? AppColors.grey50 : null,
                textColor: selected == index
                    ?  Colors.white
                    : AppColors.grey600,
                onTap: () {
                  setState(() {
                    selected = index;
                  });
                },
              ),
            );
          }),
    );
  }
}
