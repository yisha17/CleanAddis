import 'dart:io';

import 'package:clean_addis_android/bloc/Waste/waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'WasteList.dart';

class AddWastePage extends StatefulWidget {
  final int? id;
  final String? waste_name;
  final String? waste_type;
  final String? for_waste;
  final String? metric;
  final String? image;
  final String? price;
  final String? quantity;
  final String? location;
  final String? description;

  AddWastePage(
      {this.id,
      this.waste_name,
      this.waste_type,
      this.for_waste,
      this.metric,
      this.price,
      this.quantity,
      this.location,
      this.image,
      this.description});
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
  late String selectedValue = isEditing() ? widget.for_waste! : values.first;
   late String? value = isEditing() ? widget.waste_type! : null;
  File? image;
  String wasteBlank = "assets/image/recycling.png";
  final ImagePicker _picker = ImagePicker();
  final wasteBloc =
      AddWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  late final waste_name_text =
          TextEditingController(text: isEditing() ? widget.waste_name : null),
      waste_type_text =
          TextEditingController(text: isEditing() ? widget.waste_name : null),
      waste_for_text =
          TextEditingController(text: isEditing() ? widget.for_waste : null),
      waste_description_text =
          TextEditingController(text: isEditing() ? widget.description : null),
      metric_text =
          TextEditingController(text: isEditing() ? widget.metric : null),
      price_per_unit_text = TextEditingController(
          text: isEditing() ? widget.price.toString() : null),
      quantity_text = TextEditingController(
          text: isEditing() ? widget.quantity.toString() : null),
      location_text =
          TextEditingController(text: isEditing() ? widget.location : null);

  bool isEditing() {
    if (widget.id != null) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildRadios() {
    return Column(
      children: values.map(
        (e) {
          return RadioListTile<String>(
              value: e,
              groupValue: selectedValue,
              title: Text(
                e,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              onChanged: (value) => setState(
                  () => {this.selectedValue = e, print(this.selectedValue)}));
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

  void _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget imageField() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: image != null
          ? Image.file(
              image!,
              fit: BoxFit.cover,
            )
          : Image.asset(wasteBlank,height: 70,
              width: 70,
            ),
    );
  }

   Widget editimageField() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: widget.image != null
          ? image != null
          ? Image.file(
              image!,
              fit: BoxFit.cover,
            ):Image.network(
              widget.image!,
              fit: BoxFit.cover,
            )
          : Image.asset(wasteBlank,height: 70,width: 70,),
    );
  }




  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  void messageDialog(
    BuildContext context, {
    required IconData icon,
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AddWasteBloc(WasteRepository(dataProvider: WasteDataProvider())),
      child: BlocListener(
        bloc: wasteBloc,
        listener: (context, WasteState state) {
          if (state is WasteLoading) {
            WidgetsBinding.instance!
                .addPostFrameCallback((_) => loadingDialog(context));
          } else if ( state is WasteCreatedState || state is WasteUpdatedState) {
            WidgetsBinding.instance!.addPostFrameCallback((_) => messageDialog(
                    context,
                    icon: Icons.recycling,
                    color: TypeColor.chooseColor(value!),
                    title: state is WasteUpdatedState ? 'Waste Updated':'Waste Created',
                    body: 'Your Waste has been Successfully Created',
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WasteListPage(
                                    for_waste: selectedValue,
                                    type: value,
                                  )));
                        },
                        child: Text("OK",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    ]));
          } else if (state is WasteCreateFailedState) {
            Navigator.of(context, rootNavigator: true).pop();
            ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
              SnackBar(
                content: Text('error happend. please try again'),
                duration: Duration(seconds: 6),
              ),
            );
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
                      isEditing() ?
                      editimageField(): 
                      imageField(),
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
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                              ),
                              onPressed: () {
                                _pickImage(ImageSource.camera);
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
                    icon: Icon(
                      Icons.recycling,
                      color: value != null ? 
                      TypeColor.chooseColor(value!):
                      Colors.grey
                    ),
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
                    validator: (value) {
                      if (value == null) {
                        return 'Please fill this';
                      } else {
                        return null;
                      }
                    },
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
                            color: value != null
                                ? TypeColor.chooseColor(value!)
                                : Colors.grey
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
                            placeholder: "100",
                            validator: (val) {
                              if (selectedValue == 'Donation' &&
                                  int.parse(price_per_unit_text.text) > 0) {
                                return 'Donation is free';
                              } else if (!isNumeric(val!)) {
                                return 'Incorrect Value';
                              } else {
                                return null;
                              }
                            }),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: buildTextField(
                            icon: Icon(
                              Icons.production_quantity_limits,
                            ),
                            type: TextInputType.number,
                            controller: this.quantity_text,
                            labelText: "Quantity",
                            placeholder: "100",
                            validator: (val) {
                              if (!isNumeric(val!)) {
                                return 'Incorrect Value';
                              } else {
                                return null;
                              }
                            }),
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
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      type: TextInputType.name,
                      controller: this.location_text,
                      labelText: "Location",
                      placeholder: "Piassa, AddisAbaba"),
                  buildTextField(
                      icon: Icon(
                        Icons.description,
                        color: Colors.amberAccent,
                      ),
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
                        if(isEditing() == false){
                             wasteBloc.onCreateWaste(
                            for_waste: this.selectedValue,
                            waste_name: this.waste_name_text.text,
                            waste_type: this.value,
                            price_per_unit:
                                int.parse(this.price_per_unit_text.text),
                            quantity: int.parse(this.quantity_text.text),
                            metric: this.metric_text.text,
                            image: this.image,
                            location: this.location_text.text,
                            description: this.waste_description_text.text);
                        }else{
                          wasteBloc.add(UpdateWasteEvent(
                            id: widget.id!,
                            waste_name: waste_name_text.text,
                            waste_type: value,
                            for_waste: selectedValue,
                            metric: metric_text.text,
                            quantity: int.parse(quantity_text.text),
                            price_per_unit: int.parse(price_per_unit_text.text),
                            location: location_text.text,
                            description: waste_description_text.text,
                            image: image ));
                        }
                      
                   
                    },
                    child: Text(
                      isEditing()  ? 'Update':'Create' ,
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50), primary: logogreen),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
