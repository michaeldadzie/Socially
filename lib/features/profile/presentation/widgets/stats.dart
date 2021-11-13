import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Stats extends StatelessWidget {
  final int count;
  final String label;
  const Stats({
    Key? key,
    required this.count,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).focusColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.raleway(
            color: Theme.of(context).focusColor,
          ),
        )
      ],
    );
  }
}
