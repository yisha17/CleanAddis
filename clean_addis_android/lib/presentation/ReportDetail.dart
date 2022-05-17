import 'dart:io';

import 'package:clean_addis_android/presentation/ReporList.dart';
import 'package:clean_addis_android/presentation/Report.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/Report/report_bloc.dart';
import '../data/data_providers/report_data.dart';
import '../data/repositories/report_repository.dart';

class ReportDetailPage extends StatefulWidget {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? post_date;
  final String? longitude;
  final String? latitude;
  final bool? isResolved;
  const ReportDetailPage(
      {this.id,
      this.title,
      this.image,
      this.post_date,
      this.description,
      this.longitude,
      this.latitude,
      this.isResolved});

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  bool isTextfield = false;
  bool isDescriptionField = false;
  final report_title_text = TextEditingController(),
      report_description_text = TextEditingController();
  String wasteBlank =
      "https://www.freeiconspng.com/uploads/black-recycle-icon-png-2.png";

  late Future<String> address_street = GetAddressFromLatLong();
  final reportBloc =
      ReportBloc(ReportRepository(dataProvider: ReportDataProvider()));

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

  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(child: Text('Deleting')),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ));
        });
  }

  Future<String> GetAddressFromLatLong() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(widget.latitude!), double.parse(widget.longitude!));
    print(placemarks);
    Placemark place = placemarks[0];

    return '${place.street}, ${place.subLocality},${place.locality} ${place.country}';
  }

  Widget buildText({
    required Icon? icon,
    String? label,
    String? text,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon!,
              Text(
                label!,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          verticalSpace(0.01),
          Text(
            text!,
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget buildTextField(
      {required Icon icon,
      required TextInputType type,
      required String labelText,
      required String placeholder,
      required TextEditingController controller,
      final String? Function(String?)? validator,
      int? maxLines}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        maxLines: maxLines,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
            focusColor: Colors.red,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            prefixIcon: icon,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget imageholder() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: Image.network(
        widget.image!,
        fit: BoxFit.cover,
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300],
          image: DecorationImage(
              image: (image != null)
                  ? FileImage(image!)
                  : NetworkImage(wasteBlank) as ImageProvider,
              fit: BoxFit.fill)),
    );
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  Widget reportButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          child: Text(
            'Update',
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700),
          ),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            primary: Colors.red,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ReportBloc(ReportRepository(dataProvider: ReportDataProvider())),
      child: BlocListener(
        bloc: reportBloc,
        listener: (context, ReportState state) {
          if (state is ReportLoadingState) {
            WidgetsBinding.instance!
                .addPostFrameCallback((_) => loadingDialog(context));
          } else if (state is ReportDeletedState) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(
                    context: context,
                    title: 'Report Deleted',
                    body: 'Report has beed deleted successfully',
                    icon: Icons.delete_forever,
                    color: Colors.red,
                    actions: [
                      Row(
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
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReportListPage()));
                            },
                          ),
                        ],
                      )
                    ]));
          }
        },
        child: Scaffold(
            backgroundColor: lightgreen,
            appBar: AppBar(
              backgroundColor: lightgreen,
              elevation: 0,
              leading: Icon(
                Icons.arrow_back,
                color: Colors.red,
              ),
              title: Text(
                'Details',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
              centerTitle: true,
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ReportPage(
                                                  id: widget.id,
                                                  image: widget.image,
                                                  title: widget.title,
                                                  description:
                                                      widget.description,
                                                )));
                                  },
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]);
                  },
                  icon: Icon(Icons.edit),
                  color: Colors.blue,
                ),
                IconButton(
                  onPressed: () {
                    messageDialog(
                        context: context,
                        title: 'Delete Report',
                        color: Colors.red,
                        icon: Icons.delete,
                        body: 'Are you sure you want to delete your report?',
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                    reportBloc.add(ReportDeleteEvent(
                                        id: widget.id.toString()));
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
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ]);
                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
            body: Column(
              children: [
                imageholder(),
                verticalSpace(0.02),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          buildText(
                              icon: Icon(
                                Icons.report,
                                color: Colors.red,
                              ),
                              label: 'TITLE',
                              text: widget.title),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                verticalSpace(0.02),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildText(
                              icon: Icon(
                                Icons.description,
                                color: Colors.red,
                              ),
                              label: 'DESCRIPTION',
                              text: widget.description),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                verticalSpace(0.02),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildText(
                              icon: Icon(
                                Icons.date_range,
                                color: Colors.red,
                              ),
                              label: 'REPORTED ON',
                              text: widget.post_date),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
                verticalSpace(0.02),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FutureBuilder(
                              future: address_street,
                              initialData: 'Loading',
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return buildText(
                                      icon: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      label: 'Location',
                                      text: 'Loading');
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return buildText(
                                      icon: Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      label: 'Location',
                                      text: snapshot.data);
                                }
                                return Center();
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            )),
      ),
    );
  }
}
