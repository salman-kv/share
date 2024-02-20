import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTheme {
   final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    textTheme: TextTheme(
      // large text like big heading
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      // small grey fonts
      bodySmall: GoogleFonts.poppins(
        // fontWeight: FontWeight.normal,
        color: Colors.grey,
        fontSize: 16,
      ),
      // normal letters large
      displayLarge: GoogleFonts.poppins(
        // fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      // normal letters meadium
      displayMedium: GoogleFonts.poppins(
        // fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      // normal letters small
      displaySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      // titile with bold large
      titleLarge:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleMedium:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      // label for title text with invers
       labelLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 18,
      ),
     
      labelMedium:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 16,
      ),
        labelSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14,
      ),
    ),
  );
  final ThemeData darkTheme = ThemeData(
    fontFamily: 'poppins',
    brightness: Brightness.dark,
       textTheme: TextTheme(
      // large text like big heading
      bodyLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
      // small grey fonts
      bodySmall: GoogleFonts.poppins(
        // fontWeight: FontWeight.normal,
        color: Colors.grey,
        fontSize: 16,
      ),
      // normal letters large
      displayLarge: GoogleFonts.poppins(
        // fontWeight: FontWeight.w500,
        fontSize: 18,
      ),
      // normal letters meadium
      displayMedium: GoogleFonts.poppins(
        // fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
      // normal letters small
      displaySmall: GoogleFonts.poppins(
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      // titile with bold large
      titleLarge:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      titleMedium:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      titleSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      // label for title text with invers
       labelLarge: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 18,
      ),
     
      labelMedium:  GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 16,
      ),
        labelSmall: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: const Color.fromARGB(255, 0, 0, 0),
        fontSize: 14,
      ),
    ),
  );
}
