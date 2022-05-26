import 'package:clean_addis_android/bloc/Waste/waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/presentation/Location.dart';
import 'package:clean_addis_android/presentation/WasteBuy.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WasteBuyListPage extends StatefulWidget {
  final String? type;
  WasteBuyListPage({this.type});
  @override
  State<StatefulWidget> createState() {
    return WasteBuyListPageState();
  }
}



class WasteBuyListPageState extends State<WasteBuyListPage> {

  
  final wasteBloc =
      AddWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));
  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  @override
  void initState() {
    super.initState();
    wasteBloc..add(AvailableWasteListEvent(type: widget.type));
  }

  Widget wasteType(String type, Color id) {
    return InkWell(
      onTap: () {
        wasteBloc..add(AvailableWasteListEvent(type:type));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        color: id,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.recycling, color: Colors.white, size: 25),
            Text(
              type,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            )
          ],
        )),
      ),
    );
  }

  Widget createListTile({
    required int waste_id,
    required int seller,
    String? image,
    required String waste_name,
    required String waste_type,
    required String quantity,
    required String price,
    required String? location,
    required String? description,
    required String unit,
    required String for_waste,
    required String post_date,
    required bool donated,
    required bool sold,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WasteBuyPage()));
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
                            'Plastic Bottle',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.price_change,
                                    color: Color.fromARGB(255, 139, 182, 45)),
                              ),
                              Text('2000'),
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LocationPage()));
                              },
                              child: Text('view location'))
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreen,
          centerTitle: true,
          elevation: 0,
          leading: Icon(
            Icons.shopping_bag,
            color: Colors.black,
          ),
          title: Text(
            'Buy',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: lightgreen,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 10, 5),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      wasteType('Organic', Colors.green),
                      wasteType('Plastic', Colors.yellow),
                      wasteType('E-Waste', Colors.red),
                      wasteType('Paper', Colors.brown),
                      wasteType('Metal', Color.fromARGB(255, 107, 105, 105)),
                      wasteType('Glass', Colors.orangeAccent),
                      wasteType('Fabric', Color.fromARGB(255, 44, 110, 125)),
                    ],
                  )),
              BlocBuilder(
                  bloc: wasteBloc,
                  builder: (context, state) {
                    if (state is WasteLoading) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Center(child: CircularProgressIndicator())
                          ],
                        ),
                      );
                    }

                    if (state is WasteListLoaded) {
                      print('here is working');
                      final waste = state.waste;
                        print(waste);
                      return !waste.isEmpty
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: waste.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context,index){
                                  return createListTile(
                                     waste_id: waste.elementAt(index).id!,
                                     seller: waste.elementAt(index).seller!,
                                      image: '${waste.elementAt(index).image}',
                                      waste_name:
                                          '${waste.elementAt(index).waste_name}',
                                      post_date:
                                          '${waste.elementAt(index).post_date}',
                                      quantity:
                                          '${waste.elementAt(index).quantity}',
                                      unit: '${waste.elementAt(index).metric}',
                                      price:
                                          '${waste.elementAt(index).price_per_unit}',
                                      location:
                                          '${waste.elementAt(index).location}',
                                      description:
                                          '${waste.elementAt(index).description}',
                                      donated: waste.elementAt(index).donated!,
                                    sold: waste.elementAt(index).sold!,
                                      waste_type:
                                          '${waste.elementAt(index).waste_type}',
                                      for_waste:
                                          '${waste.elementAt(index).for_waste}');
                                  
                                },
                               
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                  ),
                                  Text('No Avilable Waste'),
                                ],
                              ),
                            );
                    }
                      return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Center(
                            child: Text(
                          'Sorry there is an error!!',
                          style: TextStyle(color: Colors.red),
                        )),
                      ],
                    );
                  })
            ],
          ),
        ));
  }
}
