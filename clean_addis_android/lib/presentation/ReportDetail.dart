
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportDetailPage extends StatefulWidget {
  const ReportDetailPage({ Key? key }) : super(key: key);

  @override
  State<ReportDetailPage> createState() => _ReportDetailPageState();
}

class _ReportDetailPageState extends State<ReportDetailPage> {
  File? image;
  final ImagePicker _picker = ImagePicker();
  bool isTextfield = false;
  var _formKey = GlobalKey<FormState>();
  final report_title_text = TextEditingController(),
      report_description_text = TextEditingController();
  String wasteBlank =
      "https://www.freeiconspng.com/uploads/black-recycle-icon-png-2.png";
  
  
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

  Widget buildText(){
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           'Title',
           style: TextStyle(
             fontSize: 24,
           ), 
          ),
          Text(
            'Broken Pipe',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          imageholder(),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child: Row(
                  mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                  children: [

                    isTextfield == false ?
                    buildText() :
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: buildTextField(
                        icon: Icon(Icons.title),
                        type: TextInputType.name,
                        labelText: 'update title',
                        placeholder: 'Broken Pipe',
                        controller: report_title_text),
                    ),

                      IconButton(
                        onPressed:(){
                          setState(() {
                            isTextfield == false ?
                            isTextfield = true :
                            isTextfield = false;
                          });
                        } , icon: Icon(Icons.edit))

                  ],

                ),
              )
            ],
          )

        ],
      )
    );
  }
}