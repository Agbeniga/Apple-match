import 'package:applematch/config/colors/app_colors.dart';
import 'package:applematch/config/icons/app_icons.dart';
import 'package:applematch/shared/enums/text_field_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AuthTextField extends StatefulWidget {
  final TextFieldState state;
  final String hintText;
  final String? icon;
  final TextCapitalization? capitalization;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Function(String?)? onChange;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.state,
    required this.hintText,
     this.icon,
    this.capitalization,
    this.onChange,this.keyboardType,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.84.r),
        color: Colors.white.withOpacity(0.67),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.state == TextFieldState.password && isObscure,
        enableSuggestions: widget.state != TextFieldState.password,
        cursorColor: AppColors.pink500,
        textCapitalization: widget.capitalization ?? TextCapitalization.none,
        onChanged: (value) {
          if (widget.onChange != null) {
            widget.onChange!(value);
          }
        },
        onEditingComplete: () {
          if (widget.state == TextFieldState.password) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
        style: TextStyle(
          fontSize: 14.spMin,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 14.spMin,
            fontWeight: FontWeight.w500,
            color: AppColors.grey400,
          ),
          prefixIcon:
          Visibility(
              visible: widget.icon != null,
              child:
           Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.icon != AppIcons.emailIcon ? 12.h : 14.h,
            ),
            child: widget.icon == null ? SizedBox():
               SvgPicture.asset(
                widget.icon!,
                color: AppColors.grey400,
              ),
            ),
          ),
          suffixIcon: widget.state == TextFieldState.password
              ? InkWell(
                  borderRadius: BorderRadius.circular(99),
                  onTap: () => setState(() => isObscure = !isObscure),
                  child: Ink(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: SvgPicture.asset(
                      isObscure
                          ? AppIcons.passwordVisible
                          : AppIcons.passwordNotVisible,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
