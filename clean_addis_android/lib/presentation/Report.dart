import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  var _formKey = GlobalKey<FormState>();
  final report_title_text = TextEditingController(),
      report_description_text = TextEditingController();
  String wasteBlank =
      "https://www.freeiconspng.com/uploads/black-recycle-icon-png-2.png";


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
  Widget buildTextField(
      {required Icon icon,
      required TextInputType type,
      required String labelText,
      required String placeholder,
      required TextEditingController controller,
      final String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        children: [
          imageholder(),
          buildTextField(
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
          )
        ],
      )),
    );
  }
}
