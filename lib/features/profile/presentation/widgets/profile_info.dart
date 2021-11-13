import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfo extends StatelessWidget {
  final String username;
  final String bio;
  const ProfileInfo({
    Key? key,
    required this.username,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          username,
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
