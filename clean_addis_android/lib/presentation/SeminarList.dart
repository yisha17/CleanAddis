import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class SeminarListPage extends StatefulWidget {
  const SeminarListPage({Key? key}) : super(key: key);

  @override
  State<SeminarListPage> createState() => _SeminarListPageState();
}

class _SeminarListPageState extends State<SeminarListPage> {
  Widget createCard() {
    return Container(
      height:300,
      child: Card(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 85,
                child: Image.network(
                  
                    'https://www.cleanlink.com/resources/editorial/2021/cleaning-staff-26492.jpg',
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,),
              ),
              Flexible(
                flex: 20,
                child: Center(
                  child: Text(
                    'How Cleaning and mental health related?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.date_range),
                  Text('Posted on May 22, 2022')
                ],
              )
            ],
          ),),
    );
  }

  Widget createCategories(String text,Color color){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
             color: color,
          ),
          child: Text(
            text,style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                createCategories('All',Colors.yellowAccent),
                createCategories('Plantation', Colors.green),
                createCategories('Protection', Colors.purpleAccent),
                createCategories('Cleaning', Colors.cyanAccent),
              ],
            ),
          ),
          Expanded(
            flex: 95,
            child: ListView(
              children: [
                createCard(),
                createCard(),
                createCard(),  
              ],
            ),
          ),
        ],
      ),
    );
  }
}
