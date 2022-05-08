import 'package:clean_addis_android/presentation/Location.dart';
import 'package:clean_addis_android/presentation/WasteBuy.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';


class WasteBuyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WasteBuyListPageState();
  }
}

class WasteBuyListPageState extends State<WasteBuyListPage> {
  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  Widget wasteType(String type, Color id) {
    return InkWell(
      onTap: () {
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

  Widget createListTile() {
    return InkWell(
      onTap: (){
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
                                icon: Icon(Icons.price_change, color: Color.fromARGB(255, 139, 182, 45)),
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
                              }, child: Text('view location'))
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
                  )
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                    createListTile(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
