import 'dart:io';

import 'package:clean_addis_android/bloc/Report/report_bloc.dart';
import 'package:clean_addis_android/data/data_providers/report_data.dart';
import 'package:clean_addis_android/data/repositories/report_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'ReporList.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  File? image;
  final ImagePicker _picker = ImagePicker();
  var _formKey = GlobalKey<FormState>();
  final report_title_text = TextEditingController(),
      report_description_text = TextEditingController();
  String wasteBlank =
      "https://www.freeiconspng.com/uploads/black-recycle-icon-png-2.png";

 String? longitude;
  String? latitude;

  final reportBloc = ReportBloc(ReportRepository(dataProvider: ReportDataProvider()));
  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(child: Text('checking..')),
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

  Widget imageholder() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey[300],
              image: DecorationImage(
                  image: (image != null)
                      ? FileImage(image!)
                      : NetworkImage(wasteBlank) as ImageProvider,
                  fit: BoxFit.fill)),
        ),
        Positioned(
          bottom: -10,
          right: 40,
          child: IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 30,
            ),
            onPressed: () {
              _pickImage();
            },
          ),
        ),
      ],
    );
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var positionlist = position.toString().split(':');
    var latitude = positionlist.elementAt(1).split(',').first;
    setState(() {
      this.latitude = latitude;
      this.longitude = positionlist.last;
    });
  
  }

  Widget reportButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ElevatedButton(
          child: Text(
            'Report',
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            getLocation();
            reportBloc.add(ReportCreateEvent(
              title: report_title_text.text,
              description: report_description_text.text,
              image: this.image,
              longitude: this.longitude,
              latitude: this.latitude
            ));
            print('waassup');
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size.fromHeight(50),
            primary: Colors.red,
          ),
        ));
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

   void messageDialog(
    BuildContext context,
  ) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.verified_user_sharp,
                    size: 55,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Reported',
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
                  'Your report has been successfully created.',
                  style: TextStyle(fontSize: 20),
                )
              ]),
            ),
            contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
            actions: [
              Center(
                child: ElevatedButton(
                  child: Text(
                    "OK",
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    minimumSize: Size(100, 50),
                    primary:Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReportListPage()));
                     
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Report',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
          key: _formKey,
          child: BlocProvider(
            create: (context) =>
            ReportBloc(ReportRepository(dataProvider: ReportDataProvider())),
            child: BlocListener(
              bloc: reportBloc,
              listener: (context,ReportState state){
                if(state is ReportLoadingState){
                   WidgetsBinding.instance!
                      .addPostFrameCallback((_) => loadingDialog(context));
                } else if (state.report != null && state is ReportCreatedState) {
                   WidgetsBinding.instance!
                      .addPostFrameCallback((_) => messageDialog(
                            context,
                          ));
                }else if(state is ReportErrorState){
                  Navigator.of(context, rootNavigator: true).pop();
                  ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                      .showSnackBar(
                    SnackBar(
                      content: Text('error happend. please try again'),
                      duration: Duration(seconds: 6),
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  imageholder(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: buildTextField(
                      icon: Icon(Icons.title),
                      type: TextInputType.name,
                      controller: this.report_title_text,
                      labelText: "What is The Problem",
                      placeholder: "Report here",
                      validator: (value) {
                        if (value != null && value.length < 4) {
                          return 'You Must fill title';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: buildTextField(
                      icon: Icon(Icons.title),
                      type: TextInputType.multiline,
                      controller: this.report_description_text,
                      labelText: "Describe the problem",
                      placeholder: "Report description",
                    ),
                  ),
                  reportButton(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                    child: Text(
                        'when you create your report you current location also will be sent',
                        style: TextStyle(
                          color: Colors.red,
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
