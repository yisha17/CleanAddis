import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';

class WasteBuyPage extends StatefulWidget {
  const WasteBuyPage({Key? key}) : super(key: key);

  @override
  State<WasteBuyPage> createState() => _WasteBuyPageState();
}

class _WasteBuyPageState extends State<WasteBuyPage> {
  Widget textField({
    required String title,
    required double titleSize,
    required String body,
    required double width,
    Icon? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon!,
          horizontalSpace(width),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: titleSize,
                    color: Color.fromARGB(255, 94, 84, 84)),
              ),
              
              Container(
                child: Text(
                  body,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget textTile() {
    return ListTile(
      leading: Icon(Icons.recycling, size: 26, color: Colors.blue),
      title: Text(
        'Waste Name',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
      subtitle: Text(
        'Grained Glass',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }

  Widget imageholder() {
    return Container(
      child: Stack(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                  'https://ismwaste.co.uk/images/recycling/mixed-paper.jpg',
                  fit: BoxFit.fill)),
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
      backgroundColor: lightgreen,
      body: SingleChildScrollView( 
        child: Column(
          children: [
            imageholder(),
             verticalSpace(0.03),
            textField(
                icon: Icon(
                  Icons.account_box,
                  color: Color.fromARGB(255, 18, 53, 19),
                ),
                title: 'Seller',
                titleSize: 22,
                width: 0.1,
                body: 'Yishak'),
            Divider(),
            verticalSpace(0.02),
            textField(
                icon: Icon(
                  Icons.recycling,
                  color: Color.fromARGB(255, 18, 53, 19),
                ),
                title: 'Waste Name',
                titleSize: 22,
                width: 0.1,
                body: 'Grained Glass'),
              Divider(),
            verticalSpace(0.02),
            textField(
                icon: Icon(Icons.category),
                title: 'Waste Type',
                width: 0.1,
                titleSize: 22,
                body: 'Glass'),
                Divider(),
            verticalSpace(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: textField(
                      icon: Icon(
                        Icons.price_change,
                        color: Colors.green[900],
                      ),
                      title: 'Price',
                      width: 0.1,
                      titleSize: 18,
                      body: '200 Birr'),
                ),
                horizontalSpace(0.04),
                Flexible(
                  child: textField(
                      icon: Icon(
                        Icons.scale,
                        color: Colors.lime[900],
                      ),
                      title: 'Quantity',
                      width: 0.1,
                      titleSize: 18,
                      body: '234 KG'),
                ),
              ],
            ),
            Divider(),
            verticalSpace(0.02),
            textField(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
                title: 'Location',
                width: 0.1,
                titleSize: 22,
                body: 'Piassa, Addis Ababa Around bole'),
                Divider(),
            verticalSpace(0.02),
            textField(
                icon: Icon(
                  Icons.description,
                  color: Colors.amberAccent,
                ),
                title: 'Description',
                width: 0.1,
                titleSize: 22,
                body: 'Finely grained '),
              Divider(),
              verticalSpace(0.02),  
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'BUY',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50), primary: Colors.deepPurple),
              ),
            ),
             verticalSpace(0.02),
          ],
        ),
      ),
    );
  }
}
