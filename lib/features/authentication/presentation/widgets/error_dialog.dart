import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;

  const ErrorDialog({
    Key? key,
    this.title = 'Error',
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _showIOSDialog(context)
        : _showAndroidDialog(context);
  }

  CupertinoAlertDialog _showIOSDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: GoogleFonts.lato(
            color: Theme.of(context).focusColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: GoogleFonts.lato(color: Theme.of(context).focusColor),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Ok',
            style: GoogleFonts.lato(color: Theme.of(context).focusColor),
          ),
        )
      ],
    );
  }

  AlertDialog _showAndroidDialog(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).splashColor,
      title: Text(
        title,
        style: GoogleFonts.lato(
            color: Theme.of(context).focusColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: GoogleFonts.lato(color: Theme.of(context).focusColor),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Ok',
            style: GoogleFonts.lato(color: Color.fromRGBO(41, 170, 225, 1)),
          ),
        )
      ],
    );
  }
}
