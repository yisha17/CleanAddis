import 'package:carousel_slider/carousel_slider.dart';
import 'package:clean_addis_android/data/repositories/public_repository.dart';
import 'package:clean_addis_android/helpers/responseToLocation.dart';
import 'package:clean_addis_android/widget/carousel_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../bloc/PublicPlace/publicplace_bloc.dart';
import '../data/data_providers/public_place_data.dart';
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
  late List<CameraPosition> publicPlaceList;
  List<Map> carouselData = [];

  int pageIndex = 0;
  late List<Widget> carouselItems;

  final publicPlaceBloc = PublicPlaceBloc(
      PublicPlaceRepository(dataProvider: PublicPlaceDataProvider()));
  @override
  void initState() {
    super.initState();
    initialCameraPosition = CameraPosition(target: latLng, zoom: 15);
  }

  void onMapCreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  addSourceAndLineLayer(int index, bool removeLayer) async{
    controller.animateCamera(
      CameraUpdate.newCameraPosition(publicPlaceList[index]));
      Map geometry = getGeometryFromSharedPrefs(carouselData[index]['index']);
      final _fills = {
        "type" : "FeatureCollection",
        "features" : [
          {
            "type":"Feature",
            "id" : 0,
            "properties": <String, dynamic>{},
            "geometry" : geometry
          }
        ]
      }; 

     if(removeLayer == true){
       await controller.removeLayer("lines");
       await controller.removeSource("fills");
     } 
     await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
     await controller.addLineLayer("fills", "lines", LineLayerProperties(
       lineColor:Colors.green.toHexStringRGB(),
       lineCap: "round",
       lineJoin: "round",
       lineWidth: 3
     ));
  }

  void onStyleLoadedCallback() async {

      for (CameraPosition public_place in publicPlaceList) {
      await controller.addSymbol(
        SymbolOptions(
          geometry: public_place.target,
          iconSize: 0.2,
          iconImage: "assets/image/toilet.jpg",
        ),
      );
    }
    addSourceAndLineLayer(0, false);
  }

  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublicPlaceBloc(
          PublicPlaceRepository(dataProvider: PublicPlaceDataProvider())),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: MapboxMap(
                initialCameraPosition: initialCameraPosition,
                accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
                onMapCreated: onMapCreated,
                onStyleLoadedCallback: onStyleLoadedCallback,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
              ),
            ),
            Positioned(
              left: 20,
              top: 40,
              child: TextButton(
                onPressed: () {
                  publicPlaceBloc.add(GetPublicPlaceEvent(type: 'FGr'));
                },
                child: Text('search'),
              ),
            ),
            BlocBuilder(
              bloc: publicPlaceBloc,
              builder: (context, state) {
                if (state is FinalNavigationState) {
                  final public_place = state.public;
                  print(public_place);
                  for (int index = 0; index < public_place.length; index++) {
                    num distance = getDistanceFromSharedPrefs(index) / 1000;
                    num duration = getDurationFromSharedPrefs(index) / 60;
                    carouselData.add({
                      'index': index,
                      'distance': distance,
                      'duration': duration
                    });
      

                  }
                 
                  
                  carouselData
                      .sort((a, b) => a['duration'] < b['duration'] ? 0 : 1);
                  carouselItems = List<Widget>.generate(
                      public_place.length,
                      (index) => carouselCard(
                          public_place[index].name!,
                          public_place[index].type!,
                          carouselData[index]['index'],
                          carouselData[index]['distance'],
                          carouselData[index]['duration']));

                  publicPlaceList = List<CameraPosition>
                  .generate(public_place.length, (index) => 
                  CameraPosition(target: responseConverter(public_place,carouselData[index]['index']),zoom: 15));       
                  return CarouselSlider(items: carouselItems,
                   options:CarouselOptions(
                     height: 100,
                     viewportFraction: 0.6,
                     initialPage: 0,
                     enableInfiniteScroll: false,
                     scrollDirection: Axis.horizontal,
                     onPageChanged: (int index,CarouselPageChangedReason reason){
                       setState(() => pageIndex=index);
                       addSourceAndLineLayer(index, true);
                       print(carouselData[index]);
                     },
                   ));
                   
                }
                return (CircularProgressIndicator());
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.animateCamera(
                CameraUpdate.newCameraPosition(initialCameraPosition));
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
