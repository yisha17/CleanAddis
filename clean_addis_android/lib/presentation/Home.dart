import 'package:clean_addis_android/bloc/Waste/user_waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/presentation/UserProfile.dart';
import 'package:clean_addis_android/presentation/WasteBuyList.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../main.dart';
import 'AddWaste.dart';
import 'Login.dart';
import 'EditProfile.dart';
import 'WasteList.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final wastebloc =
      UserWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));

  @override
  void initState() {
    super.initState();
    wastebloc..add(HomePageOpenedEvent());
    initializeLocationAndSave();
  }

  void initializeLocationAndSave() async {
    Location _location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    permissionGranted = await _location.hasPermission();

    if (permissionGranted == _location.hasPermission()) {
      permissionGranted = await _location.requestPermission();
    }

    LocationData locationData = await _location.getLocation();

    LatLng currentLatLng =
        LatLng(locationData.latitude!, locationData.longitude!);

    sharedPreferences.setDouble('latitude', locationData.latitude!);
    sharedPreferences.setDouble('longitude', locationData.longitude!);
  }

  NetworkImage chooseImage(String type) {
    if (type == 'Plastic') {
      return NetworkImage(
          'https://cdn.mos.cms.futurecdn.net/WTXCtPFr6P7EygfJZ8DsA3-1024-80.jpg.webp');
    } else if (type == 'Glass') {
      return NetworkImage(
          'https://vertassets.blob.core.windows.net/image/88a322f7/88a322f7-ac3b-4e06-826c-57e0ec0b77a2/375_250-all_kinds_of_glass_bottles.jpg');
    } else if (type == 'Electronics') {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    } else if (type == 'Textile') {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    } else if (type == 'Metal') {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    } else {
      return NetworkImage(
          'https://www.google.com/imgres?imgurl=https%3A%2F%2Fcdn.mos.cms.futurecdn.net%2FWTXCtPFr6P7EygfJZ8DsA3.jpg&imgrefurl=https%3A%2F%2Fwww.livescience.com%2Fvanilla-flavor-plastic-waste.html&tbnid=KfcaCXXEW3QcTM&vet=12ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ..i&docid=DTONEIjGusKzJM&w=1280&h=853&q=plastic%20waste&ved=2ahUKEwipxf_n-rD3AhUPWhoKHUY-BsMQMygSegUIARD4AQ');
    }
  }

  Widget wasteType(String type, Color id) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => WasteBuyListPage()));
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
            Icon(Icons.recycling, color: Colors.white, size: 35),
            Text(
              type,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        )),
      ),
    );
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightgreen,
        elevation: 0,
        leading: Icon(Icons.home, color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.help,
              color: Colors.blue,
            ),
            onPressed: () => {print("yishak")},
          ),
          IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.account_circle,
              color: logogreen,
            ),
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserProfilePage()))
            },
          ),
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
              color: Colors.red,
            ),
            onPressed: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginPage()))
            },
          ),
        ],
      ),
      backgroundColor: lightgreen,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                'Hello Yishak!',
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Welcome to Clean",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                    ),
                  ),
                  TextSpan(
                    text: "Addis",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Color(0xff68EA26)),
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Items For Sell',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WasteListPage(
                            for_waste: 'Sell',
                            type: 'Organic',
                          )))
                    },
                    child: Text(
                      'Details',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: BlocBuilder(
                    bloc: wastebloc,
                    builder: (context, state) {
                      if (state is WasteLoadingState) {
                        return ListView(
                          children: [
                            Center(child: CircularProgressIndicator())
                          ],
                        );
                      }

                      if (state is WasteLoaded) {
                        final waste = state.waste;
                        final waste_donation = waste
                            .where((element) => element.for_waste == 'Sell')
                            .toList();
                        return waste_donation.isEmpty
                            ? Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddWastePage()));
                                  },
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: logogreen,
                                width: MediaQuery.of(context).size.width * 0.25,
                              )
                            : ListView.builder(
                                itemCount: waste_donation.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (index <= waste_donation.length - 1) {
                                    return InkWell(
                                      onTap: () {
                                        print(
                                            '${waste.elementAt(index).for_waste}');
                                        print(index);
                                        print(waste_donation.length);
                                        print('${waste_donation.elementAt(index).post_date}');
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.115,
                                              child: Image(
                                                image: NetworkImage(
                                                    '${waste_donation.elementAt(index).image}'),
                                                fit: BoxFit.fill,
                                              )),
                                          Center(
                                              child: Text(
                                                  '${waste_donation.elementAt(index).waste_name}'))
                                        ],
                                      ),
                                    );
                                  } else {
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddWastePage()));
                                        },
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      color: Colors.grey,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.115,
                                    );
                                  }
                                  return Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddWastePage()));
                                      },
                                    ),
                                    margin:
                                        EdgeInsets.fromLTRB(10, 0, 10, 20),
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.11,
                                  );
                                });
                      }
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Donations',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
  
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => 
                          WasteListPage(for_waste: 'Donation',type:'Pastic'))),

                    },
                    child: Text(
                      'Details',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: BlocBuilder(
                    bloc: wastebloc,
                    builder: (context, state) {
                      if (state is WasteLoadingState) {
                        return ListView(
                          children: [
                            Center(child: CircularProgressIndicator())
                          ],
                        );
                      }

                      if (state is WasteLoaded) {
                        final waste = state.waste;
                        final waste_donation = waste
                            .where((element) => element.for_waste == 'Donation')
                            .toList();
                        return waste_donation.isEmpty
                            ? Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddWastePage()));
                                  },
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                color: logogreen,
                                width: MediaQuery.of(context).size.width * 0.25,
                              )
                            : ListView.builder(
                                itemCount: waste_donation.length + 1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  if (index <= waste_donation.length - 1) {
                                    return InkWell(
                                      onTap: () {
                                        print(
                                            '${waste.elementAt(index).for_waste}');
                                        print(index);
                                        print(waste_donation.length);
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.115,
                                              child: Image(
                                                image: NetworkImage(
                                                    '${waste_donation.elementAt(index).image}'),
                                                fit: BoxFit.fill,
                                              )),
                                          Center(
                                              child: Text(
                                                  '${waste_donation.elementAt(index).waste_name}'))
                                        ],
                                      ),
                                    );
                                  } else {
                                    Container(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 40,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddWastePage()));
                                        },
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      color: logogreen,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.115,
                                    );
                                  }
                                  return Container(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddWastePage()));
                                      },
                                    ),
                                    margin:
                                         EdgeInsets.fromLTRB(10, 0, 10, 20),
                                    color: Colors.grey,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    height: MediaQuery.of(context).size.height *
                                        0.115,
                                  );
                                });
                      }
                      return Center(
                        child: Text('Loading'),
                      );
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Items',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () => {print("njgd")},
                  //   child: Text(
                  //     'Details',
                  //     style: TextStyle(color: Colors.grey, fontSize: 13),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    wasteType('Organic', Colors.green),
                    wasteType('Plastic', Colors.yellow),
                    wasteType('E-Waste', Colors.red),
                    wasteType('Paper', Colors.brown),
                    wasteType('Metal', Color.fromARGB(255, 107, 105, 105)),
                    wasteType('Glass', Colors.orangeAccent),
                    wasteType('Fabric', Color.fromARGB(255, 44, 110, 125))
                  ],
                ),
              ),
              verticalSpace(0.02)
            ],
          ),
        ),
      ),
    );
  }
}
