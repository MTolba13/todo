import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:todo/style/colors.dart';

class Themes {
  static final myTheme = ThemeData(
    //AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: MyColors.myWhite,
      elevation: 1,
    ),

    // Scaffold
    scaffoldBackgroundColor: MyColors.myWhite,
  );
}
//Todo Remove //

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 24,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
  );
}
