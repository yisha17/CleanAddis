import 'dart:io';

import 'package:clean_addis_android/bloc/Waste/waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddWastePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddWasteState();
  }
}

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ));
}

class AddWasteState extends State<AddWastePage> {
  final list = waste_type;
  static const values = <String>['Donation', 'Sell'];
  String selectedValue = values.first;
  String? value;
  File? image;
  String wasteBlank =
      "https://www.freeiconspng.com/uploads/black-recycle-icon-png-2.png";
  final ImagePicker _picker = ImagePicker();
  final wasteBloc =
      AddWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final waste_name_text = TextEditingController(),
      waste_type_text = TextEditingController(),
      waste_for_text = TextEditingController(),
      waste_description_text = TextEditingController(),
      metric_text = TextEditingController(),
      price_per_unit_text = TextEditingController(),
      quantity_text = TextEditingController(),
      location_text = TextEditingController();

  Widget buildRadios() {
    return Column(
      children: values.map(
        (e) {
          return RadioListTile<String>(
              value: e,
              groupValue: selectedValue,
              title: Text(e,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
              onChanged: (value) => setState(() => this.selectedValue = e));
        },
      ).toList(),
    );
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
            focusColor: logogreen,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: logogreen),
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

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddWasteBloc(WasteRepository(dataProvider: WasteDataProvider())),
      child: BlocListener(
        bloc: wasteBloc,
        listener: (context, WasteState state) {
          if (state is AddWasteWaitingState) {
            WidgetsBinding.instance!
                .addPostFrameCallback((_) => loadingDialog(context));
          } else if (state.waste != null && state is WasteCreatedState) {
            
          } else if (state is WasteCreateFailedState) {
            print(state.message.toString());
          }
        },
        child: Scaffold(

          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: lightgreen,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                 Navigator.of(context).pop();
              },
            ),
            title: Center(
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Icon(
                  Icons.assignment_outlined,
                  size: 30,
                  color: Colors.black,
                ),
                Text(
                  'Waste Form',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
          ),
          backgroundColor: lightgreen,
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: ListView(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                                image: (image != null)
                                    ? FileImage(image!)
                                    : NetworkImage(wasteBlank) as ImageProvider,
                                fit: BoxFit.cover)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Row(
                          children: [
                            IconButton(
                            icon: Icon(
                              Icons.image_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                            ),
                            onPressed: () {
                              _pickImage();
                            },
                          ),
                          ],
                        ),
                      )
                     
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,

                  ),
                  buildTextField(
                    icon: Icon(Icons.recycling),
                    type: TextInputType.name,
                    controller: this.waste_name_text,
                    labelText: "Waste name",
                    placeholder: "Plastic Bottle",
                    validator: (value) {
                      if (value != null && value.length < 4) {
                        return 'You Must fill waste name';
                      } else {
                        return null;
                      }
                    },

                  ),
                  DropdownButtonFormField(
                    isDense: true,
                    items: list.map((String category) {
                      return new DropdownMenuItem(
                          value: category,
                          child: Row(
                            children: <Widget>[
                              Text(category),
                            ],
                          ));
                    }).toList(),
                    onChanged: (String? newValue) {
                      // do other stuff with _category
                      setState(
                          () => {this.value = newValue, print(this.value)});
                    },
                    value: value,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(

                          borderSide: BorderSide(color: logogreen),
                        ),
                        prefixIcon: Icon(
                          Icons.category,
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
                        labelText: 'Waste Type',
                        hintText: "Plastic",
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        )),
                  ),

                   SizedBox(
   height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Row(
                    children: [
                      new Flexible(
                        child: buildTextField(
                            icon: Icon(Icons.price_change_outlined),
                            type: TextInputType.number,
                            controller: this.price_per_unit_text,
                            labelText: "price",
                            placeholder: "100"),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: buildTextField(
                            icon: Icon(Icons.production_quantity_limits),
                            type: TextInputType.number,
                            controller: this.quantity_text,
                            labelText: "Quantity",
                            placeholder: "100"),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: buildTextField(
                            icon: Icon(Icons.scale),
                            type: TextInputType.name,
                            controller: this.metric_text,
                            labelText: "Unit",
                            placeholder: "KG"),
                      ),
                    ],
                  ),
                  buildTextField(
                      icon: Icon(Icons.location_on,color: Colors.red,),
                      type: TextInputType.name,
                      controller: this.location_text,     
                      labelText: "Location",
                      placeholder: "Piassa, AddisAbaba"),
                  buildTextField(
                      icon: Icon(Icons.description,color: Colors.amberAccent,),
                      type: TextInputType.name,
      controller: this.waste_description_text,
                      labelText: "Description",
                      placeholder: "Description here"),
                  Text(
                    'Waste For',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.black),
                  ),
                  buildRadios(),
                  ElevatedButton(
                      onPressed: () {
                        wasteBloc.onCreateWaste(
                            for_waste: 'Sell',
                            waste_name: this.waste_name_text.text,
                            waste_type: this.value,
                            price_per_unit:
                                int.parse(this.price_per_unit_text.text),
                            quantity: int.parse(this.quantity_text.text),
                            metric: this.metric_text.text,
                            image: this.image,
                            location: this.location_text.text,
                            description: this.waste_description_text.text);
                      },
                      child: Text('Create',style: TextStyle(fontSize: 26,fontWeight: FontWeight.w700),),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        primary: logogreen
                      ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
