import 'package:clean_addis_android/presentation/ReportDetail.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Report/report_bloc.dart';
import '../data/data_providers/report_data.dart';
import '../data/repositories/report_repository.dart';
import 'Report.dart';

class ReportListPage extends StatefulWidget {
  const ReportListPage({Key? key}) : super(key: key);

  @override
  State<ReportListPage> createState() => _ReportListPageState();
}

class _ReportListPageState extends State<ReportListPage> {
 
  final reportBloc = ReportBloc(ReportRepository(dataProvider: ReportDataProvider()));


   @override
   void initState(){
     reportBloc..add(ReportListEvent());
     super.initState();
   }


  Widget createListTile() {
    return InkWell(
      onTap:() {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ReportDetailPage()));
      },
      child: Container(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
            ReportBloc(ReportRepository(dataProvider: ReportDataProvider())),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreen,
          elevation: 0,
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
        body: BlocBuilder(
          bloc:reportBloc,
           builder: (context,state) {
                  if (state is ReportLoadingState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [Center(child: CircularProgressIndicator())],
                      );
                  }

                  if(state is ReportListState){
                    final reportList = state.reportList;
                    return reportList.isEmpty ?

                     Center(
                      child: Text('you dont have any Report yet')
                    ):

                     ListView.builder(
                      itemCount: reportList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context,index){
                        return createListTile();
                      },
                     
                                       );
                    

                  }

                  return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [Center(child: CircularProgressIndicator())],
                        )
                      );
                  
           }
          // child: ListView(
          //   children: [
          //     createListTile(),
          //     createListTile(),
          //     createListTile(),
          //     createListTile(),
          //     createListTile(),
          //     createListTile(),
          //     createListTile(),
          //   ],
          // ),
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
      ),
    );
  }
}
