import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Color bordersideColor;
  final Color? backgroundColor;
  final Color textColor;
  final Function() onPress;
  const CustomButton({
    required this.title,
    required this.bordersideColor,
    this.backgroundColor,
    required this.textColor,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width.h,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 15.h,
            bottom: 15.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.h),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 2.h,
            color: bordersideColor,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title!,
          style: GoogleFonts.raleway(
            fontSize: 17.h,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
