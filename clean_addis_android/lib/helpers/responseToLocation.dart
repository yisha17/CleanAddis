
import 'package:mapbox_gl/mapbox_gl.dart';
import '../data/models/public_place.dart';

LatLng responseConverter(List<PublicPlace> place,int i){
  return LatLng(double.parse(place[i].latitude!), 
  double.parse(place[i].longitude!));
} 