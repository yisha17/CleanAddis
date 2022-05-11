import 'dart:io';

import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportDetailPage extends StatefulWidget {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final String? post_date;
  final String? longitude;
  final String? latitude;
  final bool? isResolved;
  const ReportDetailPage({
    this.id,
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
      child: Image.network(widget.image!,fit: BoxFit.cover,),
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
    return Scaffold(
      backgroundColor: lightgreen,
      appBar: AppBar(
        backgroundColor: lightgreen,
        elevation: 0,
        leading: Icon(Icons.arrow_back,color: Colors.red,),
        title: Text('Details',style: TextStyle(color: Colors.red,fontSize: 25),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed:(){}, 
            icon: Icon(Icons.edit),color: Colors.blue,),
             IconButton(
              onPressed: () {},
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
                   icon: Icon(Icons.report,color: Colors.red,),
                   label: 'TITLE',
                    text: 'Broken Pipe'),
                      
              
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
                          icon: Icon(Icons.description,color: Colors.red,),
                          label: 'DESCRIPTION',
                          text:
                              widget.description),
                      
                
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
                          text: widget.post_date
                              ),
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
                            Icons.location_on,
                            color: Colors.red,
                          ),
                          label: 'Location',
                          text: widget.post_date),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
       
      ],
    ));
  }
}
