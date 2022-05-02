import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';

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
                    child: Center(
                      child: Text(
                        'Broken Pipe',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.date_range),
                          Text('Reported on May 12, 2022'),
                        ],
                      )),
                  Expanded(
                    flex: 25,
                    child: Text(
                      'Resolved',
                      style: TextStyle(
                        backgroundColor: Colors.red,
                        color: Colors.white, 
                      ),
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
      body: ListView(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
