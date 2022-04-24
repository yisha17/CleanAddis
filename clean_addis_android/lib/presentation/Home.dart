import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightgreen,
        elevation: 1,
        leading: Icon(Icons.home,color:Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.blue,
            ),
            onPressed: () => {print("yishak")},
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.settings,
              color: logogreen,
            ),
            onPressed: () => {print("yishak")},
          ),
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            onPressed: () => {print("yishak")},
          ),
        ],
      ),
      backgroundColor: lightgreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(
            //       padding: EdgeInsets.all(0),
            //       icon: Icon(
            //         Icons.account_circle,
            //         color: Colors.black,
            //       ),
            //       onPressed: () => {print("yishak")},
            //     ),
            //     IconButton(
            //       icon: Icon(
            //         Icons.help,
            //         color: Colors.black,
            //       ),
            //       onPressed: () => {print("yishak")},
            //     ),
            //     IconButton(
            //       icon: Icon(
            //         Icons.logout_rounded,
            //         color: Colors.black,
            //       ),
            //       onPressed: () => {print("yishak")},
            //     ),
            //   ],
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'Hello Yishak!',
              textAlign: TextAlign.left,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.black),
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                  text: "Welcome to Clean",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w200,
                    fontSize: 26,
                  ),
                ),
                TextSpan(
                  text: "Addis",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Color(0xff68EA26)),
                    fontWeight: FontWeight.w200,
                    fontSize: 26,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Items For Sell',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => {print("njgd")},
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: Image(
                      image: NetworkImage(
                          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.yellow,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Donations',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => {print("njgd")},
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.yellow,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Available Items',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () => {print("njgd")},
                  child: Text(
                    'Details',
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.14,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.green,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.yellow,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.blue,
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
