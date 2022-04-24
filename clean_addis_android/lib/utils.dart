 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget cleanAddislogo() {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(children: <TextSpan>[
      TextSpan(
        text: "Clean",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(color: Colors.black),
          fontWeight: FontWeight.w900,
          fontSize: 34,
        ),
      ),
      TextSpan(
        text: "Addis",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(color: Color(0xff68EA26)),
          fontWeight: FontWeight.w900,
          fontSize: 34,
        ),
      ),
    ]),
  );
}



Color lightgreen = Color(0xffe9fff3);









