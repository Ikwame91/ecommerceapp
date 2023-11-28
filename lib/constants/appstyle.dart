import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appstyle(double size, Color color, FontWeight weight) {
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: weight,
  );
}

TextStyle appstyletwo(
    double size, Color color, FontWeight weight, double height) {
  return GoogleFonts.poppins(
    fontSize: size,
    color: color,
    fontWeight: weight,
    height: height,
  );
}
