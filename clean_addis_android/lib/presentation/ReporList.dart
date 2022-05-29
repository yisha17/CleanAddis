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
  final reportBloc =
      ReportBloc(ReportRepository(dataProvider: ReportDataProvider()));

  @override
  void initState() {
    reportBloc..add(ReportListEvent());
    super.initState();
  }

  Widget createListTile(
      {required int? id,
      required String? image,
      required String? raw_date,
      required String? title,
      String? description,
      required String? latitude,
      required String? longitude,
      required bool isResolved}) {
    var post_date = DateFormatter.changetoMD(raw_date!);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReportDetailPage(
                id: id,
                image: image,
                post_date: post_date,
                title: title,
                description: description,
                latitude: latitude,
                longitude: longitude,
                isResolved: isResolved)));
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
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 66,
                child: Column(
                  children: [
                    Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 25,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.date_range),
                              Text('Reported on $post_date',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 35,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isResolved
                                ? Container(
                                    color: Colors.green,
                                    child: Text(
                                      'Resolved',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                : Container(
                                    color: Colors.red,
                                    child: Text(
                                      'Unresolved',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                            TextButton(
                              onPressed: () {},
                              child: Text.rich(TextSpan(children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                  ),
                                ),
                                TextSpan(
                                  text: 'View Location',
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )
                              ])),
                            ),
                            //   SizedBox(
                            //     width: 50,
                            //   ),
                            //   Icon(
                            //     Icons.location_on,
                            //     color: Colors.red,
                            //   ),
                            //   TextButton(
                            //       onPressed: () {}, child: Text('view location'))
                          ],
                        ),
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
            bloc: reportBloc,
            builder: (context, state) {
              if (state is ReportLoadingState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [Center(child: CircularProgressIndicator())],
                );
              }

              if (state is ReportListState) {
                final reportList = state.reportList;
                return reportList.isEmpty
                    ? Center(child: Text('you dont have any Report yet'))
                    : ListView.builder(
                        itemCount: reportList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return createListTile(
                            id: reportList.elementAt(index).id,
                            image: '${reportList.elementAt(index).image}',
                            raw_date:
                                '${reportList.elementAt(index).post_date}',
                            title: '${reportList.elementAt(index).title}',
                            description:
                                '${reportList.elementAt(index).description}',
                            latitude: '${reportList.elementAt(index).latitude}',
                            longitude:
                                '${reportList.elementAt(index).longitude}',
                            isResolved: reportList.elementAt(index).isResolved!,
                          );
                        },
                      );
              }

              return Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [Center(child: CircularProgressIndicator())],
              ));
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ReportPage()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
