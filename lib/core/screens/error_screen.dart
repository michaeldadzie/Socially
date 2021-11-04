import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Theme.of(context).focusColor),
        title: Text(
          'Error',
          style: GoogleFonts.raleway(color: Theme.of(context).focusColor),
        ),
      ),
      body: Center(
        child: Text('Something went wrong',
            style: GoogleFonts.raleway(
                color: Theme.of(context).focusColor, fontSize: 15)),
      ),
    );
  }
}
