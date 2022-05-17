
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:latlong2/latlong.dart' as latLng;

class PublicPlacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PublicPlacePageState();
  }
}

class PublicPlacePageState extends State<PublicPlacePage> {


  void initState(){
    super.initState();

  }

  void initializeLocationAndSave() async{
    Location _location = Location();
    bool? serviceEnabled;
    PermissionStatus? permissionGranted;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled){
      serviceEnabled = await _location.requestService();
    }
    permissionGranted = await _location.hasPermission();

    if (permissionGranted == _location.hasPermission()){
      permissionGranted = await _location.requestPermission();
    }

    LocationData locationData = await _location.getLocation();
    
    

    

  }
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: latLng.LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                  "https://api.mapbox.com/styles/v1/yizhak/cl1qq5p2o003915rqrn7asfe0/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoieWl6aGFrIiwiYSI6ImNsMXFwdmR2NzBlejAzbW8zb292M3NsYXMifQ.obOs_McfR5JF9nIKI8zTNg",
              additionalOptions: {
                'accessToken':
                    'pk.eyJ1IjoieWl6aGFrIiwiYSI6ImNsMXFwdmR2NzBlejAzbW8zb292M3NsYXMifQ.obOs_McfR5JF9nIKI8zTNg',
                'id': 'mapbox.mapbox-streets-v8'
              },
            ),
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 100.0,
                  height: 100.0,
                  point: latLng.LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (builder) {
                              print('yshak');
                              return Container(
                                height: 200,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '5 kilo Car Parking',
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          Icons.car_rental,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.04,
                                    ),
                                    RatingBar.builder(
                                      initialRating: 3,
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        switch (index) {
                                          case 0:
                                            return Icon(
                                              Icons.sentiment_very_dissatisfied,
                                              color: Colors.red,
                                            );
                                          case 1:
                                            return Icon(
                                              Icons.sentiment_dissatisfied,
                                              color: Colors.redAccent,
                                            );
                                          case 2:
                                            return Icon(
                                              Icons.sentiment_neutral,
                                              color: Colors.amber,
                                            );
                                          case 3:
                                            return Icon(
                                              Icons.sentiment_satisfied,
                                              color: Colors.lightGreen,
                                            );
                                          case 4:
                                            return Icon(
                                              Icons.sentiment_very_satisfied,
                                              color: Colors.green,
                                            );
                                          
                                           
                                        }
                                        return SizedBox();
                                      },
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),

                                    TextButton(
                                      onPressed:(){

                                      }, 
                                      child:Text(
                                        'Rate',
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize:20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ))
                                    
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.04,
          right: 20,
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.green,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                isSearching ? isSearching = false : isSearching = true;
              });
            },
          ),
        ),
        isSearching
            ? Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                right: 20,
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.park),
                      color: Colors.purpleAccent,
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.public),
                      color: Colors.deepOrange,
                      iconSize: 30,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bathroom),
                      color: Colors.blueAccent,
                      iconSize: 30,
                    ),
                  ],
                ))
            : SizedBox()
      ],
    ));
  }
}
