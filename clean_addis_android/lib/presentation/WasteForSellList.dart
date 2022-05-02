import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WasteForSellPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WasteForSellPageState();
  }
}

class WasteForSellPageState extends State<WasteForSellPage> {

   Widget createListTile() {
    return Container(
      height: 100,
      color: lightgreen,
      child: Card(
        color: lightgreen,
        child: Row(
          children: [
            Expanded(
              flex: 33,
              child: Image.network(
                'https://picsum.photos/250?image=9',
              ),
            ),
            Expanded(
              flex: 66,
              child: Column(
                children: [
                 Expanded(
                    flex: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Plastic Bottle',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        )
                        
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.date_range),
                          Text('Posted on May 12, 2022',style:TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                        ],
                      )),
                  Expanded(
                    flex: 25,
                    child: Row(
                      children: [
                        
                        Container(
                          color:Colors.green,
                          child: Text(
                            'Resolved',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500, 
                            ),
                          ),
                        ),
                        SizedBox(
                          width:50,
                        ),

                        Icon(Icons.location_on,color: Colors.red,),
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            'view location'
                          ))
                        
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightgreen,
        centerTitle: true,
        leading: SizedBox(height: 10, width: 10,child: Image.asset('image/recycling.png',fit: BoxFit.fill,)),
        title: Text(
          'Waste For Sell',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: lightgreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
        child: Column(
          children: [
            
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  createListTile()
                  // Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[


            //               Expanded(
            //                 flex: 2,
            //                 child: Container(
            //                   height: 80,
            //                   width: 80,
            //                   color: Colors.red,
            //                 ),
            //               ),
            //               Expanded(
            //                 flex: 4,
            //                 child: Column(
            //                   children: [
            //                     Row(
            //                       children: [
            //                         SizedBox(
            //                           width: MediaQuery.of(context).size.width *
            //                               0.08,
            //                         ),
            //                         Text(
            //                           'Plastic Bottle',
            //                           style: GoogleFonts.montserrat(
            //                             textStyle: TextStyle(color: Colors.black),
            //                             fontSize: 20,
            //                             fontWeight: FontWeight.w700,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height:
            //                           MediaQuery.of(context).size.width * 0.02,
            //                     ),
            //                     Row(
            //                       children: [
            //                         SizedBox(
            //                           width: MediaQuery.of(context).size.width *
            //                               0.08,
            //                         ),
            //                         Icon(Icons.monitor_weight, size: 15),
            //                         Text(
            //                           '15kg',
            //                           style: TextStyle(
            //                             color: Colors.black,
            //                             fontSize: 18,
            //                             fontWeight: FontWeight.w500,
            //                           ),
            //                         ),
            //                         SizedBox(
            //                           width: MediaQuery.of(context).size.width *
            //                               0.02,
            //                         ),
            //                         Icon(Icons.price_change ,size: 15),
            //                         Text(
            //                           '100 Birr/KG',
            //                           style: TextStyle(
            //                             color: Colors.black,
            //                             fontSize: 18,
            //                             fontWeight: FontWeight.w500,
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       height: MediaQuery.of(context).size.width * 0.01,
            //                     ),
            //                     Row(
            //                       mainAxisAlignment: MainAxisAlignment.end,
            //                       children: [
            //                         SizedBox(
            //                           width: MediaQuery.of(context).size.width *
            //                               0.03,
            //                         ),
            //                         Text(
            //                           'SOLD',
            //                           style: TextStyle(
            //                             color: Color(0xff68EA26),
            //                             fontSize: 15,
            //                             fontWeight: FontWeight.w800,
            //                           ),
            //                         ),
            //                         TextButton(
            //                           onPressed: () => {print('delete')},
            //                           child: Text(
            //                             'Edit',
            //                             style: TextStyle(
            //                               color: Colors.blue,
            //                               fontSize: 16,
            //                               fontWeight: FontWeight.w500,
            //                             ),
            //                           ),
            //                         ),
            //                         TextButton(
            //                           onPressed: () => {print('delete')},
            //                           child: Text(
            //                             'Delete',
            //                             style: TextStyle(
            //                               color: Colors.red,
            //                               fontSize: 16,
            //                               fontWeight: FontWeight.w500,
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.only(top: 5),
            //                 child: Container(
            //                     height: 15, width: 15, color: Colors.green),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
                ],
              ),
            )
          ],
        ),

           
      ));
    
  }
}
