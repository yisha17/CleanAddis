import 'package:clean_addis_android/presentation/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWastePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddWasteState();
  }
}

Widget buildWastename() => TextField(
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(
            Icons.ac_unit_sharp,
            color: Colors.black,
          ),
          labelText: 'Waste Name',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
    );

  Widget buildPricePerUnit() => TextField(
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(
            Icons.ac_unit_sharp,
            color: Colors.black,
          ),
          labelText: 'Price/Unit',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
    ); 
    Widget buildUnit() => TextField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
          prefixIcon: Icon(
            Icons.ac_unit_sharp,
            color: Colors.black,
          ),
          labelText: 'Price/Unit',
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder()),
    ); 

DropdownMenuItem<String> buildMenuItem(String item) {
  return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ));
}

class AddWasteState extends State<AddWastePage> {
  

  final list = ['dab', 'sdf', 'sdfs', 'sfsdf'];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => {print('nsdf')},
                  icon: Icon(Icons.arrow_back),
                  iconSize: 34,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14,
                ),
                Text(
                  'Plastic Bottle',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.black),
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                )
              ],
            ),

            
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.07,
            ),
            buildWastename(),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.04,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     border:Border.all(width: 2,color: Colors.black)
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton<String>(

            //       iconSize: 36,
            //       icon: Icon(Icons.arrow_drop_down,color: Colors.black),
            //       value: value ,
            //       isExpanded: true,
            //       items: list.map(buildMenuItem).toList(),
            //       onChanged: (value) =>  setState(()=> this.value = value)
            //     ),
            //   ),
            // )

            DropdownButtonFormField(
              items: list.map((String category) {
                return new DropdownMenuItem(
                    value: category,
                    child: Row(
                      children: <Widget>[
                        Text(category),
                      ],
                    ));
              }).toList(),
              onChanged: (newValue) {
                // do other stuff with _category
                setState(() => this.value = value);
              },
              value: value,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: Icon(
                  Icons.category,
                  color: Colors.black,
                ),
                contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                labelText: 'Waste Type',
                hintText: "waste type",
              ),
            ),
            
            


          ],
        ),
      ),
    );
  }
}
