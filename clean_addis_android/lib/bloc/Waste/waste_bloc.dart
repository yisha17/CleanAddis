import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/waste.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


part 'waste_event.dart';
part 'waste_state.dart';

class AddWasteBloc extends Bloc<AddWasteEvent, WasteState> {
  WasteRepository repository;
  AddWasteBloc(this.repository) : super(WasteState());

  void onCreateWaste({ 
    String? for_waste,
  String? waste_name,
  String? waste_type,
  int? price_per_unit,
  int? quantity,
  String? metric,
  File? image,
  String? location,
  String? description}){
    add(CreateWasteEvent(
      waste_name:waste_name,
      waste_type: waste_type!, 
      for_waste: for_waste!, 
      metric: metric!, 
      quantity: quantity!, 
      price_per_unit: price_per_unit!, 
      location: location!,
      image: image,
      description: description
      ));
  }

 
  Stream<WasteState> mapEventToState(AddWasteEvent event) async*{
    
    if (event is CreateWasteEvent){
      print("waste create command");
      try{
      yield AddWasteWaitingState();
      final _storage = FlutterSecureStorage();
      final user_id = await _storage.read(key: 'id');

      Waste waste = Waste(
        waste_name: event.waste_name,
        waste_type: event.waste_type,
        for_waste: event.for_waste,
        seller:  int.parse(user_id!),
        quantity: event.quantity,
        metric: event.metric,
        price_per_unit : event.price_per_unit,
        location: event.location,
        description: event.description
      );
      print(waste.waste_name);
      print(event.image!.path);
      final token = await _storage.read(key: 'token');
      print(token);
      final data = await repository.createWaste(waste,token!,event.image!);
      print(data);
      yield WasteCreatedState(waste:data);
    }catch(e){
      yield WasteCreateFailedState(e.toString());
    }
  
    }
    
  }
}
