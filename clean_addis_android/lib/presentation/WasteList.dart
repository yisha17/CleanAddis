import 'package:clean_addis_android/presentation/AddWaste.dart';
import 'package:clean_addis_android/presentation/WasteDetail.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Waste/user_waste_bloc.dart';
import '../data/data_providers/waste_data.dart';
import '../data/repositories/waste_repository.dart';

class WasteListPage extends StatefulWidget {
  final String? for_waste;
  final String? type;
  WasteListPage({this.for_waste, this.type});
  @override
  State<StatefulWidget> createState() {
    return WasteListPageState();
  }
}

class WasteListPageState extends State<WasteListPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  final wastebloc =
      UserWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));

  @override
  void initState() {
    this._controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    wastebloc
      ..add(DetailPageEvent(for_waste: widget.for_waste!, type: widget.type!));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  Widget wasteType(
      {required String type, required Color id, required bool isRotating}) {
    return InkWell(
      onTap: () {
        isRotating ? false : true;

        _controller.repeat();
        wastebloc
          ..add(DetailPageEvent(for_waste: widget.for_waste!, type: type));
        //  Navigator.of(context).push(MaterialPageRoute(
        //                   builder: (context) => WasteDetailPage()));
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
            isRotating == false
                ? Icon(Icons.recycling, color: Colors.white, size: 25)
                : RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Icon(Icons.recycling, color: Colors.white, size: 25),
                  ),
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
    var date = DateFormatter.changetoMD(post_date);
    return InkWell(
      onTap: () {
        print(waste_id);
        print(quantity);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WasteDetailPage(
                  waste_id: waste_id,
                  waste_name: waste_name,
                  waste_type: waste_type,
                  for_waste: for_waste,
                  quantity: quantity,
                  location: location,
                  post_date: date,
                  unit: unit,
                  donated: donated,
                  sold: sold,
                  price: price,
                  image: image,
                )));
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
                child: image != null
                    ? Image.network(
                        image,
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        'https://picsum.photos/250?image=9',
                        fit: BoxFit.cover,
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
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              waste_name,
                              style: TextStyle(
                                color: TypeColor.chooseColor(waste_type),
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Icon(Icons.date_range),
                            Text('Posted on $date',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                description != null
                                    ? description.length > 16
                                        ? 'Description: ' +
                                            description.substring(0, 16) +
                                            '...'
                                        : 'Description: $description'
                                    : 'No description',
                                  
                                style: TextStyle(
                                  color: Colors.black,
                                
                                  fontWeight: FontWeight.w300,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              color: donated ? Colors.green : Colors.yellow,
                              child: Text(
                                donated ? 'Donated' : 'Available',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                            ),
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreen,
          elevation: 0,
          centerTitle: true,
          leading: Icon(
            Icons.compost,
            color: Colors.black,
          ),
          title: Text(
            widget.for_waste!,
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddWastePage()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
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
                      wasteType(
                          type: 'Organic', id: Colors.green, isRotating: true),
                      wasteType(
                          type: 'Plastic',
                          id: Colors.yellow,
                          isRotating: false),
                      wasteType(
                          type: 'E-Waste', id: Colors.red, isRotating: false),
                      wasteType(
                          type: 'Paper', id: Colors.brown, isRotating: false),
                      wasteType(
                          type: 'Metal',
                          id: Color.fromARGB(255, 107, 105, 105),
                          isRotating: false),
                      wasteType(
                          type: 'Glass',
                          id: Colors.orangeAccent,
                          isRotating: false),
                      wasteType(
                          type: 'Fabric',
                          id: Color.fromARGB(255, 44, 110, 125),
                          isRotating: false),
                    ],
                  )),
              BlocBuilder(
                  bloc: wastebloc,
                  builder: (context, state) {
                    if (state is WasteLoadingState) {
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

                    if (state is WasteLoaded) {
                      final waste = state.waste;
                      print('here');

                      return waste.isEmpty
                          ? Center(
                              child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.3,
                                ),
                                Text('you dont have any donations yet'),
                              ],
                            ))
                          : Expanded(
                              child: ListView.builder(
                                itemCount: waste.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return createListTile(
                                      waste_id: waste.elementAt(index).id!,
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
