import 'package:clean_addis_android/presentation/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WasteDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WasteDetailState();
  }
}

class WasteDetailState extends State<WasteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => {print('nsdf')},
                  icon: Icon(Icons.arrow_back),
                  iconSize: 34,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14,
                ),
                Text(
                  'Plastic Bottle',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: [
                  Image.network(
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg")
                ])
          ],
        ),
      ),
    );
  }
}
