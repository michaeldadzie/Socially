import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textFormFieldDecoration = InputDecoration(
  hintText: '',
  fillColor: Colors.white,
  filled: true,
  hintStyle: GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(136, 147, 164, 1),
  ),
  errorStyle: GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: new BorderSide(color: Colors.red),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
      color: Color.fromRGBO(19, 119, 188, 1),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey.shade200),
  ),
);
