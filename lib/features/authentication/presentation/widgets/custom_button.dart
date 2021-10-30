import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 20,
            bottom: 20,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: backgroundColor,
          side: BorderSide(
            width: 2,
            color: bordersideColor,
          ),
        ),
        onPressed: onPress,
        child: Text(
          title!,
          style: GoogleFonts.raleway(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
