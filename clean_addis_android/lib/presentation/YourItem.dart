import 'package:clean_addis_android/presentation/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SellItemsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SellItemsPageState();
  }
}

class SellItemsPageState extends State<SellItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
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
                  'Your Items',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  // Row(
                  //   children: [
                  //     Container(
                  //       height: 80,
                  //       width:  80,
                  //       color: Colors.red,
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(

                  //           children:[
                  //             Text('Plastic Bottle',style: TextStyle(fontSize: 25),)
                  //           ]
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // )

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 80,
                              width: 80,
                              color: Colors.red,
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    Text(
                                      'Plastic Bottle',
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(color: Colors.black),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                    Icon(Icons.monitor_weight, size: 15),
                                    Text(
                                      '15kg',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.02,
                                    ),
                                    Icon(Icons.price_change ,size: 15),
                                    Text(
                                      '100 Birr/KG',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    Text(
                                      'SOLD',
                                      style: TextStyle(
                                        color: Color(0xff68EA26),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => {print('delete')},
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () => {print('delete')},
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Container(
                                height: 15, width: 15, color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
