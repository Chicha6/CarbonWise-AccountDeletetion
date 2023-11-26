import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const greenThemeLight = Color.fromARGB(255, 91, 190, 61);
const greenThemeDark = Color(0xff48a434);

final tFlabelStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black);

final tFTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white);

final tfBoxDecorationStyle = BoxDecoration(
  color: greenThemeLight,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final hintTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white54);
