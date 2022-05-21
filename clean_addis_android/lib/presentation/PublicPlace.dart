import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../helpers/sharedprefs.dart';

class PublicPlacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PublicPlacePageState();
  }
}

class PublicPlacePageState extends State<PublicPlacePage> {
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition initialCameraPosition;
  late MapboxMapController controller;
 

 @override
 void initState(){
   super.initState();
   initialCameraPosition = CameraPosition(target: latLng,zoom: 15);
 }


 void onMapCreated(MapboxMapController controller) async{
   this.controller = controller;
   
 }
 void onStyleLoadedCallback(){}

  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: MapboxMap(
              initialCameraPosition: initialCameraPosition,
              accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
              onMapCreated : onMapCreated,
              onStyleLoadedCallback: onStyleLoadedCallback,
              myLocationEnabled: true,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              minMaxZoomPreference: const MinMaxZoomPreference(14, 17) ,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         controller.animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition)); 
        },
        child:const Icon(Icons.my_location) ,),
    );
  }
}
