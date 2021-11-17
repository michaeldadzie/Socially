import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfo extends StatelessWidget {
  final String bio;
  final String name;
  const ProfileInfo({
    Key? key,
    required this.bio,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).focusColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          bio,
          style: GoogleFonts.lato(
            fontSize: 15,
            color: Theme.of(context).focusColor,
          ),
        )
      ],
    );
  }
}
