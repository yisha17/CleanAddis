import 'package:clean_addis_android/presentation/AddWaste.dart';
import 'package:clean_addis_android/presentation/WasteDetail.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/Waste/user_waste_bloc.dart';
import '../data/data_providers/waste_data.dart';
import '../data/repositories/waste_repository.dart';

class WasteDonationListPage extends StatefulWidget {

  final String? for_waste;
  final String? type;
  WasteDonationListPage({this.for_waste,this.type});
  @override
  State<StatefulWidget> createState() {
    return WasteDonationListPageState();
  }
}

class WasteDonationListPageState extends State<WasteDonationListPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
     

  final wastebloc =
      UserWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));
  bool isPressed = false;
 

  @override
  void initState() {
    
     this._controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    wastebloc..add(DetailPageEvent(for_waste: widget.for_waste!, type: widget.type!));
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

  Widget wasteType(String type, Color id) {

    return InkWell(
      
      onTap: (){

        setState(() {
          isPressed == false ? 
          isPressed = true:
          isPressed = false;
        });

        _controller.forward(from: 0.0);
        wastebloc
          ..add(DetailPageEvent(
              for_waste: widget.for_waste!, type:type));
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
            isPressed ?
            Icon(Icons.recycling, color: Colors.white, size: 25):
            RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Icon(Icons.recycling, color: Colors.white, size: 25),
                  ),
            Text(
              type,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
            )
          ],
        )),
      ),
    );
  }

  Widget createListTile() {
    return InkWell(
      onTap: () {
         Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WasteDetailPage()));
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
                          Container(
                            color: Colors.green,
                            child: Text(
                              'Donated',
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
            'Donations',
            style: TextStyle(
              color: Colors.black,
              fontSize: 26,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddWastePage()));
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
                child:ListView(
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
                )
              ),
              BlocBuilder(
                bloc: wastebloc,
                builder: (context,state) {
                  if (state is WasteLoadingState) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [Center(child: CircularProgressIndicator())],
                        ),
                      );
                  }

                  if (state is WasteLoaded){
                    final waste = state.waste;
                    print('here');
                   
                    return waste.isEmpty ?
                    Center(
                      child: Text('you dont have any donations yet')
                    ):
                    Expanded(
                    child: ListView.builder(
                      itemCount: waste.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context,index){
                        return createListTile();
                      },
                     
                    ),
                  );

                  }
                  return Center(
                    child:Text('sorry there is an error')
                  );
                  // return Expanded(
                  //   child: ListView(
                  //     scrollDirection: Axis.vertical,
                  //     children: [
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                  //       createListTile(),
                        
                  //     ],
                  //   ),
                  // );
                }
              )
            ],
          ),
        ));
  }
}
