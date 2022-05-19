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

class DateFormatter {
  static String changetoMD(String date) {
    //2022-05-16T19:41:38.444026Z
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    var datelist = date.split('-');
    var year = datelist[0];
    var month = months[int.parse(datelist[1]) - 1];
    var day = datelist[2].substring(0, 2);

    return '$month $day, $year';
  }
}

class TypeColor {
 static Color chooseColor(String type) {
    switch (type) {
      case 'Plastic':
        {
          return Colors.yellow;
        }
      case 'Glass':
        {
          return Colors.orange;
        }
      case 'E-Waste':
        {
          return Colors.red;
        }
      case 'Fabric':
        {
          return Color.fromARGB(255, 44, 110, 125);
        }
      case 'Metal':
        {
          return Color.fromARGB(255, 107, 105, 105);
        }
      case 'Organic':
        {
          return Colors.green;
        }
        case 'Paper':
        {
          return Colors.brown;
        }
        
      default:
        {
          return Colors.black;
        }
    }
   
  }
}

class DefaultImage{
   NetworkImage chooseImage(String type) {

     switch(type){
       
     }
    if (type == 'Plastic') {
      return NetworkImage(
          'https://cdn.mos.cms.futurecdn.net/WTXCtPFr6P7EygfJZ8DsA3-1024-80.jpg.webp');
    } else if (type == 'Glass') {
      return NetworkImage(
          'https://vertassets.blob.core.windows.net/image/88a322f7/88a322f7-ac3b-4e06-826c-57e0ec0b77a2/375_250-all_kinds_of_glass_bottles.jpg');
    } else if (type == 'Electronics') {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    } else if (type == 'Textile') {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    } else if (type == 'Metal') {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    } else {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    }
  }
}



