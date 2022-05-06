 import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

class SecureStorageUtil {
  static FlutterSecureStorage _preferences = FlutterSecureStorage();

  static Future<String?> getString(String key, {String defValue = ''}) {
    return _preferences.read(key: key);
  }

  static Future<void> putString(String key, String value) {
    return _preferences.write(key: key, value: value);
  }
}





Color lightgreen = Color(0xffe9fff3);
Color logogreen = Color(0xff68EA26);








