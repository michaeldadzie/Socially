import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CenteredText extends StatelessWidget {
  final String text;
  const CenteredText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: GoogleFonts.lato(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
