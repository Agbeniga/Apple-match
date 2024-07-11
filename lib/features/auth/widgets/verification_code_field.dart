import 'package:applematch/config/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationCodeField extends StatefulWidget {
  final TextEditingController controller;
  final bool isFirst;
  final bool isLast;

  const VerificationCodeField({
    super.key,
    required this.controller,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  State<VerificationCodeField> createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  @override
  Widget build(BuildContext context) {
    widget.controller.addListener(() {
      setState(() {});
    });

    return Container(
      margin: widget.isLast ? null : EdgeInsets.only(right: 10.w),
      alignment: Alignment.center,
      height: 60.h,
      width: 40.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.h,
        ),
        color: Colors.transparent,
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        cursorHeight: 40.h,
        cursorColor: AppColors.pink500,
        style: TextStyle(
          fontSize: 41.spMin,
          fontFamily: 'assets/fonts/Inter_VariableFont.ttf',
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onEditingComplete: () {
          if (widget.isLast) {
            FocusScope.of(context).unfocus();
          }
        },

        // FUNCTION TO HANDLE THE ADD OF NUMBERS OR DELETING OF NUMBERS
        onChanged: (value) {
          // if the value in that container is already full I.E(= 1) then move to the next container
          if (value.length == 1 && !widget.isLast) {
            FocusScope.of(context).nextFocus();
          }
          // if the value in this container has been removed then move to the pervious container
          else if (value.isEmpty && !widget.isFirst) {
            FocusScope.of(context).previousFocus();
          }
        },
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(
            4.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: widget.controller.text.isNotEmpty ? 2.0 : 1.5,
              color: widget.controller.text.isNotEmpty
                  ? AppColors.black100
                  : AppColors.grey400,
            ),
            borderRadius: BorderRadius.circular(13.h),
          ),
          border: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(13.h),
            borderSide: const BorderSide(
              width: 1.5,
              color: AppColors.grey400,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(13.h),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.black,
            ),
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderRadius: BorderRadius.circular(13.h),
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.red.shade900,
            ),
          ),
          errorStyle: const TextStyle(fontSize: 0),
        ),
      ),
    );
  }
}
