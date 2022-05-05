import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WasteBuyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WasteBuyListPageState();
  }
}

class WasteBuyListPageState extends State<WasteBuyListPage> {
  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  Widget createListTile() {
    return Container(
      height: 100,
      color: lightgreen,
      child: Card(
        color: lightgreen,
        child: Row(
          children: [
            Expanded(
              flex: 33,
              child: Image.network(
                'https://picsum.photos/250?image=9',
              ),
            ),
            Expanded(
              flex: 66,
              child: Column(
                children: [
                  Expanded(
                    flex: 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Plastic Bottle',
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
                          Text('Posted on May 12, 2022',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      )),
                  Expanded(
                    flex: 25,
                    child: Row(
                      children: [
                        
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        TextButton(
                            onPressed: () {}, child: Text('view location'))
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreen,
          centerTitle: true,
          leading: Icon(
            Icons.compost,
            color: Colors.black,
          ),
          title: Text(
            'Donations',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        backgroundColor: lightgreen,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.01,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
