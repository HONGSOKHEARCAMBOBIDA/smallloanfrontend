import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  // Example of a custom text style using Google Fonts
  static TextStyle siemreap(BuildContext context, {double fontSize = 16, Color color = Colors.black,FontWeight fontweight =FontWeight.normal,}) {
    return GoogleFonts.siemreap(
      fontSize: fontSize,
      color: color,
      fontWeight: fontweight
    );
  }

  // Add more custom text styles as needed
  static TextStyle anotherStyle(BuildContext context, {double fontSize = 14, Color color = Colors.blue}) {
    return GoogleFonts.koulen(
      fontSize: fontSize,
      color: color,
    );
  }
}