import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const tabBarColor = Color(0xFFDCDCDC);
  static const tabBarNotSelectedIconColor = Color(0xFF555454);
  static const greenColor = Color(0xFF92C848);
  static const lightGrayColor = Color(0xFFD9D9D9);
  static const darkGrayColor = Color(0xFFD4D4D4);
  static const orangeColor = Color(0xFFFB7B4E);
  static const lightYellowColor = Color(0xFFFFB038);
  static const lightBlackColor = Color(0xFF736A6A);

  static TextStyle headingTextStyle = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w400).fontFamily,
    fontSize: 12,
    color: blackColor,
  );

  static TextStyle subHeadingTextStyle = TextStyle(
    fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w400).fontFamily,
    fontSize: 8,
    color: blackColor,
  );

  static TextStyle labelTextStyle = TextStyle(
    fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,
    fontSize: 6,
    color: blackColor,
  );

  static TextStyle labelMediumTextStyle = TextStyle(
    fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,
    fontSize: 5,
    color: blackColor,
  );
}
