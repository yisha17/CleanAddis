import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/public_place.dart';
import 'package:clean_addis_android/helpers/directions_handler.dart';
import 'package:clean_addis_android/helpers/responseToLocation.dart';
import 'package:clean_addis_android/helpers/sharedprefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:meta/meta.dart';

import '../../data/repositories/public_repository.dart';

part 'publicplace_event.dart';
part 'publicplace_state.dart';

class PublicPlaceBloc extends Bloc<PublicPlaceEvent, PublicPlaceState> {
  PublicPlaceRepository repository;
  PublicPlaceBloc(this.repository): super(PublicPlaceState());

  Stream<PublicPlaceState> mapEventToState(PublicPlaceEvent event) async*{
    if (event is GetPublicPlaceEvent){
      try{
        yield PublicPlaceLoadingState();
         final _storage = FlutterSecureStorage();
         final token = await _storage.read(key: 'token');
         final data = await repository.getPublicPlaceByType(token!,event.type);
         yield PublicPlaceLoadedState(public: data!);
        LatLng currentLatLng = getLatLngFromSharedPrefs();
       
         for(int i = 0; i < data.length; i++){
           LatLng publicLatLng = responseConverter(data, i);
           Map modifiedResponse = await getDirectionsAPIResponse(currentLatLng, publicLatLng, i);
           saveDirectionsAPIResponse(i, json.encode(modifiedResponse));
         }

         yield FinalNavigationState(public: data);
         
      }catch(e){
        ErrorState(message: e.toString());
      }
    }
  }
}
