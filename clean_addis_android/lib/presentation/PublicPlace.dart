import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class PublicPlacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PublicPlacePageState();
  }
}

class PublicPlacePageState extends State<PublicPlacePage> {
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
                  width: 80.0,
                  height: 80.0,
                  point: latLng.LatLng(51.5, -0.09),
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
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

        isSearching ?
        Positioned(
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
            )):
            SizedBox()
      ],
    ));
  }
}
