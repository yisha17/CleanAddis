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
    seminarBloc..add(SeminarPageOpened());
    super.initState();
  }

  Widget createCard({
    required String? title,
    required String? imageLink,
    required String? post_date,
    required String? link,
  }) {
     var fromDate = DateFormatter.changetoMD(post_date!);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SeminarPage(link:link!)));
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
                imageLink!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Flexible(
                flex: 20,
                child: Center(
                  child: Text(
                    title!,
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
                  Text('Posted on $fromDate')
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
          title: Text('Seminar',
          style: TextStyle(color: Colors.black),),
          centerTitle:true,
          backgroundColor: lightgreen,
          elevation: 0,
        ),
        backgroundColor: lightgreen,
        body: BlocBuilder(
          bloc: seminarBloc,
          builder: (context,state) {
            if (state is SeminarInitial){
              Center(
                child: CircularProgressIndicator(color: 
                Colors.green),
              );
            }
            if (state is SeminarLoaded){
              final seminars = state.seminars;

              if (seminars.isEmpty){
                return Center(
                  child: Text('Sorry, We have not prepared a seminar yet'),
                );
              }else{
                 return ListView.builder(
                   itemCount: seminars.length,
                   scrollDirection: Axis.vertical,
                   itemBuilder: (context,index){
                     return  createCard(
                    title: '${seminars.elementAt(index).title}',
                    imageLink: '${seminars.elementAt(index).image}',
                    post_date: '${seminars.elementAt(index).postdate}',
                    link: '${seminars.elementAt(index).link}'
                  );
                   }
              );

              }

            }
            return Center(
              child: Text(
                'Sorry error happened'
              ),
            );
          }
        ),
      ),
    );
  }
}
