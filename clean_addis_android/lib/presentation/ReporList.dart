import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';

import 'Report.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({Key? key}) : super(key: key);

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
 
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
                          'Broken Pipe',
                          style: TextStyle(
                            color: Colors.red,
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
                          Text('Reported on May 12, 2022',style:TextStyle(
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
                            'Resolved',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500, 
                            ),
                          ),
                        ),
                        SizedBox(
                          width:50,
                        ),

                        Icon(Icons.location_on,color: Colors.red,),
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            'view location'
                          ))
                        
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
          Icons.report,
          size: 26,
          color: Colors.red,
        ),
        title: Text(
          'Your Report',
          style: TextStyle(
            color: Colors.red,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: lightgreen,
      body: SingleChildScrollView(
        child: ListView(
          children: [
            createListTile(),
            createListTile(),
            createListTile(),
            createListTile(),
            createListTile(),
            createListTile(),
            createListTile(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => 
              ReportPage()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
