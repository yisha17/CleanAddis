import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/Waste/user_waste_bloc.dart';

class WasteDetailPage extends StatefulWidget {
  final int? waste_id;
  final String? image;
  final String? waste_name;
  final String? waste_type;
  final String? for_waste;
  final String? quantity;
  final String? price;
  final String? unit;
  final String? post_date;
  final bool? donated;

  final String? location;
  final String? description;
  WasteDetailPage(
      {this.waste_id,
      this.waste_name,
      this.waste_type,
      this.for_waste,
      this.image,
      this.quantity,
      this.unit,
      this.price,
      this.post_date,
      this.donated,
      this.location,
      this.description});
  @override
  State<StatefulWidget> createState() {
    return WasteDetailState();
  }
}

class WasteDetailState extends State<WasteDetailPage> {
  static const values = <String>['Donation', 'Sell'];
  String selectedValue = values.first;

  Widget imageholder(String? image) {
    return Container(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: image != null ? 
          Image.network(
              image,
              fit: BoxFit.cover):
               Image.network(
              'https://ismwaste.co.uk/images/recycling/mixed-paper.jpg',
              fit: BoxFit.fill)
            )
    );
  }

  Widget textField({
    required String title,
    required double titleSize,
    required String body,
    Icon? icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
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
      ],
    );
  }

  void messageDialog({
    required BuildContext context,
    IconData? icon,
    required Color color,
    required String title,
    required String body,
    required List<Widget> actions,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Container(
                color: color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      icon,
                      size: 55,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              content: Container(
                height: 80,
                child: Column(children: [
                  Text(
                    body,
                    style: TextStyle(fontSize: 20),
                  )
                ]),
              ),
              contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              actions: actions);
        });
  }

  Widget buildText(
      {required IconData? icon,
      bool isFullWidth = true,
      String? label,
      required String text,
      required Color color}) {
    return Container(
      width:isFullWidth ? MediaQuery.of(context).size.width * 0.8:
      MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 21,
                color: color,
              ),
              horizontalSpace(0.01),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          verticalSpace(0.01),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        centerTitle: true,
        title : Text(
          'Details',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: TypeColor.chooseColor(widget.waste_type!),
        actions: [
           IconButton(
            onPressed: () {
              messageDialog(
                  context: context,
                  title: 'Edit Report',
                  color: Colors.blue,
                  body: 'Are you sure you want to Edit your report?',
                  icon: Icons.edit,
                  actions: [
                    Center(
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            } 
                          ),
                          TextButton(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
            },
            icon: Icon(Icons.edit),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              messageDialog(
                  context: context,
                  title: 'Delete Waste',
                  color: Colors.red,
                  icon: Icons.delete,
                  body: 'Are you sure you want to delete your waste?',
                  actions: [
                    Center(
                      child: Row(
                        children: [
                          TextButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              
                            },
                          ),
                          TextButton(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ]);
            },
            icon: Icon(Icons.delete),
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: lightgreen,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            children: [
              imageholder(widget.image),
              verticalSpace(0.03),
              buildText(
                  icon: Icons.recycling,
                  label: 'Waste Name',
                  text: widget.waste_name!,
                  color: TypeColor.chooseColor(widget.waste_type!)),
              Divider(),
              verticalSpace(0.03),
              buildText(
                  icon: Icons.category,
                  label: 'Waste Type',
                  text: widget.waste_type!,
                  color: TypeColor.chooseColor(widget.waste_type!)),
              Divider(),
              verticalSpace(0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  horizontalSpace(0.09),
                  buildText(
                      icon: Icons.price_change,
                      color: Colors.green[900]!,
                      isFullWidth: false,
                      label: 'Price',
                      text: widget.price! + 'Birr'),
                  horizontalSpace(0.04),
                  buildText(
                      icon: Icons.scale,
                      color: Colors.lime[900]!,
                      isFullWidth: false,
                      label: 'Quantity',
                      text:  widget.quantity! + widget.unit!),
                ],
              ),
              Divider(),
              verticalSpace(0.03),
              buildText(
                  icon: Icons.date_range,
                  color: TypeColor.chooseColor(widget.waste_type!),
                  label: 'Waste Created',
                  text: 'Created on ' + widget.post_date!),
              Divider(),
              verticalSpace(0.03),
              buildText(
                  icon: Icons.location_on,
                  color: Colors.red,
                  label: 'Location',
                  text: widget.location != null ? widget.location! : 'No Location'),
              Divider(),
              verticalSpace(0.03),
              buildText(
                  icon: Icons.description,
                  color: Colors.amberAccent,
                  label: 'Description',
                  text: widget.description != null ? widget.description!: 'No description'),
              Divider(),
              verticalSpace(0.03),
               buildText(
                  icon: Icons.sell,
                  color: TypeColor.chooseColor(widget.waste_type!),
                  label: 'Waste For',
                  text: widget.for_waste!),
              Divider(),
              verticalSpace(0.03),
              buildText(
                  icon: Icons.shop_two,
                  color: TypeColor.chooseColor(widget.waste_type!),
                  label: 'Status',
                  text: widget.donated! ? 'Donated' : 'Available'),
             
            ],
          ),
        ),
      ),
    );
  }
}
