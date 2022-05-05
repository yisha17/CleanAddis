import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
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
      ],
    ));
  }
}
