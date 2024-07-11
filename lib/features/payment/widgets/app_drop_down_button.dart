import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropDownButton extends StatefulWidget {
  final List items;
  final Object? stateValue;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Color? borderColor;
  final Color? buttonColor;
  final bool? isExpanded;
  final Color? textColor;
  final double? itemHeight;
  final FontWeight? textWeight;
  final void Function(Object?)? onChanged;

  const AppDropDownButton({
    super.key,
    required this.items,
    required this.stateValue,
    required this.onChanged,
    this.textColor,
    this.textWeight,
    this.borderRadius,
    this.borderColor,
    this.isExpanded,
    this.width,
    this.height,
    this.itemHeight,
    this.buttonColor,
  });

  @override
  State<AppDropDownButton> createState() => _AppDropDownButtonState();
}

class _AppDropDownButtonState extends State<AppDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 103.w,
      height: widget.height ?? 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
        color: Colors.white,
        border: Border.all(
          color: widget.borderColor ?? AppColors.black300,
          width: 1.5,
        ),
      ),
      child: DropdownButton(
        menuMaxHeight: widget.itemHeight,
        padding: EdgeInsets.only(right: 11.w, left: 19.w),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
        isExpanded: widget.isExpanded ?? true,
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: widget.buttonColor ?? const Color(0xFF004852).withOpacity(0.7),
        ),
        items: widget.items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item.runtimeType == int && item.toString().length < 2
                      ? '0$item'
                      : item.toString(),
                  style: TextStyle(
                    fontWeight: widget.textWeight ?? FontWeight.w600,
                    fontSize: 14.spMin,
                    color: widget.textColor ?? AppColors.black300,
                  ),
                ),
              ),
            )
            .toList(),
        value: widget.stateValue,
        onChanged: widget.onChanged,
      ),
    );
  }
}
