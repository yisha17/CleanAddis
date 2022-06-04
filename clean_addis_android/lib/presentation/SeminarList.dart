import 'package:clean_addis_android/bloc/Seminar/seminar_bloc.dart';
import 'package:clean_addis_android/data/data_providers/seminar_data.dart';
import 'package:clean_addis_android/presentation/Seminar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repositories/seminar_repo.dart';
import '../utils.dart';

class SeminarListPage extends StatefulWidget {
  const SeminarListPage({Key? key}) : super(key: key);

  @override
  State<SeminarListPage> createState() => _SeminarListPageState();
}

class _SeminarListPageState extends State<SeminarListPage> {
  final seminarBloc = SeminarBloc(SeminarRepo(SeminarDataProvider()));

  @override
  void initState(){
    // seminarBloc..add(SeminarPageOpened());
    super.initState();
  }

  Widget createCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SeminarPage()));
      },
      child: Container(
        height: 300,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 85,
                child: Image.network(
                  'https://www.cleanlink.com/resources/editorial/2021/cleaning-staff-26492.jpg',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
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
          ),
        ),
      ),
    );
  }

  Widget createCategories(String text, Color color) {
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
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => SeminarBloc(SeminarRepo(SeminarDataProvider())),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Seminar',),
          centerTitle:true,
          backgroundColor: lightgreen,
          
        ),
        backgroundColor: lightgreen,
        body: ListView(
          children: [
            createCard(),
            createCard(),
            createCard(),
          ],
        ),
      ),
    );
  }
}
