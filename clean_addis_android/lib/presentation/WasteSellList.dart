import 'package:clean_addis_android/presentation/AddWaste.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';


class WasteForSellPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WasteForSellPageState();
  }
}

class WasteForSellPageState extends State<WasteForSellPage> {

  Widget wasteType(String type, Color id) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: id,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.recycling, color: Colors.white, size: 35),
          Text(
            type,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          )
        ],
      )),
    );
  }


  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }   
  Widget createListTile({
    String? imageSrc,
    required String name,
    required bool isSold,
  }) {
    return Container(
      color: lightgreen,
      child: Card(
        color: lightgreen,
        child: Row(
          children: [
            Expanded(
              flex: 33,
              child: imageSrc != null ? 
              Image.network(
                imageSrc,
              ):
              wasteType('Glass', Colors.orangeAccent)
            ),

            Expanded(
              flex: 66,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 Expanded(
                    flex: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.edit, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.delete, color: Colors.red),
                            ),
                          ],
                        )
                        
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.date_range),
                          Text('Posted on May 12, 2022',style:TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                        ],
                      )),
                  Expanded(
                    flex: 25,
                    child: Row(
                      children: [
                        
                        Container(
                          color:Colors.green,
                          child: Text(
                            'Sold',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500, 
                            ),
                          ),
                        ),
                        SizedBox(
                          width:50,
                        ),

                       
                       
                        
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightgreen,
        centerTitle: true,
        elevation:0,
        leading: Icon(Icons.sell,color: Colors.black,),
        title: Text(
          'Waste For Sell',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddWastePage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red, ),
      backgroundColor: lightgreen,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
        child: Column(
          children: [

            SizedBox(
                height: MediaQuery.of(context).size.width * 0.01,
            ),
            
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.01,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  createListTile(name: 'Plasic Bottle',isSold:true),
                    createListTile(imageSrc:'https://www.newraybottles.com/wp-content/uploads/2019/11/4-glass-bottles-junk-1.png',name: 'Grained Glass', isSold: false),
                    createListTile(imageSrc:
                    'https://media.livingstonepartners.com/wp-content/uploads/2019/05/13101705/Metal-Waste-Deal-Image-1024x681.jpg',
                    name: 'Metal Pan', 
                    isSold: false),
                    createListTile(name: 'Almunium Cans', isSold: true),
                    createListTile(name: 'Plastic Bottle', isSold: true),
                ],
              ),
            )
          ],
        ),

           
      ));
    
  }
}
