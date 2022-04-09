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


Widget buildUsername() => TextField(
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(
            Icons.account_box,
            color: Colors.black,
          ),
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
    );



     Widget buildPassword() => TextField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.black,
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
    );

Color lightgreen = Color(0xffe9fff3);









