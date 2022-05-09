import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/Waste/user_waste_bloc.dart';

class WasteDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WasteDetailState();
  }
}

class WasteDetailState extends State<WasteDetailPage> {
  
  static const values = <String>['Donation', 'Sell'];
  String selectedValue = values.first;

  Widget imageholder() {
    return Container(
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  'https://ismwaste.co.uk/images/recycling/mixed-paper.jpg',
                  fit: BoxFit.fill)),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget textField({
    required String title,
    required double titleSize,
    required String body,
    Icon? icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icon!,
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: titleSize,
                  color: Color.fromARGB(255, 94, 84, 84)),
            ),
            Text(
              body,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                  color: Colors.black),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  Widget wasteFor() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.sell),
        Text(
          'Sell',
          style: TextStyle(
            fontSize:18,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: Colors.blue,
          ),
        ),
      ],
    );    
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: lightgreen,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            children: [
              imageholder(),
              verticalSpace(0.03),
              textField(
                  icon: Icon(
                    Icons.recycling,
                    color: Color.fromARGB(255, 18, 53, 19),
                  ),
                  title: 'Waste Name',
                  titleSize: 22,
                  body: 'Grained Glass'),
              verticalSpace(0.04),
              textField(
                  icon: Icon(Icons.category),
                  title: 'Waste Type',
                  titleSize: 22,
                  body: 'Glass'),
              verticalSpace(0.04),
              Row(
                children: [
                  Flexible(
                    child: textField(
                        icon: Icon(
                          Icons.price_change,
                          color: Colors.green[900],
                        ),
                        title: 'Price',
                        titleSize: 18,
                        body: '200 Birr'),
                  ),
                  horizontalSpace(0.1),
                  Flexible(
                    child: textField(
                        icon: Icon(
                          Icons.scale,
                          color: Colors.lime[900],
                        ),
                        title: 'Quantity',
                        titleSize: 18,
                        body: '234 KG'),
                  ),
                ],
              ),
              verticalSpace(0.04),
              textField(
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  title: 'Location',
                  titleSize: 22,
                  body: 'Piassa, Addis Ababa Around bole'),
              verticalSpace(0.04),
              Container(
                width: MediaQuery.of(context).size.width,
                child: textField(
                    icon: Icon(
                      Icons.description,
                      color: Colors.amberAccent,
                    ),
                    title: 'Description',
                    titleSize: 22,
                    body: 'Finely grained bottle '),
              ),
              verticalSpace(0.02),
              Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              
              Text(
                'Waste For',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color.fromARGB(255, 94, 84, 84)),
              ),
             wasteFor(),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
