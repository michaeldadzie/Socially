import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textFormFieldDecoration = InputDecoration(
  hintText: '',
  filled: true,
  hintStyle: GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade500,
  ),
  errorStyle: GoogleFonts.lato(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.transparent),
  ),
);
