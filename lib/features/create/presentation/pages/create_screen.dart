import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Create',
          style: GoogleFonts.raleway(color: Theme.of(context).focusColor),
        ),
      ),
    );
  }
}
