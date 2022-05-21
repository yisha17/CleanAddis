import 'package:clean_addis_android/bloc/PublicPlace/publicplace_bloc.dart';
import 'package:clean_addis_android/data/repositories/public_repository.dart';
import 'package:clean_addis_android/helpers/mapbox_request.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../main.dart';



Future<Map> getDirectionsAPIResponse(LatLng currentLatLng,LatLng publicLatLng, int index) async {
  
  final response = await getWalkingRouteUsingMapbox(
      currentLatLng,
      LatLng(publicLatLng.latitude,publicLatLng.longitude));
  Map geometry = response['routes'][0]['geometry'];
  num duration = response['routes'][0]['duration'];
  num distance = response['routes'][0]['distance'];
  
  print(distance);
  print(duration);

  Map modifiedResponse = {
    "geometry": geometry,
    "duration": duration,
    "distance": distance,
  };
  return modifiedResponse;
}

void saveDirectionsAPIResponse(int index, String response) {
  sharedPreferences.setString('public place--$index', response);
}
