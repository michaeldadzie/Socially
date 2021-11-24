import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

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
          backgroundColor: const Color.fromRGBO(41, 170, 225, 1),
          side: BorderSide(
            width: 2.h,
            color: const Color.fromRGBO(41, 170, 225, 1),
          ),
        ),
        onPressed: () {},
        child: Center(
          child: SizedBox(
            width: 20.5.h,
            height: 20.5.h,
            child: CircularProgressIndicator(
              strokeWidth: 2.h,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
