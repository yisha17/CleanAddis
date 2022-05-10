
import 'dart:io';

import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/models/waste.dart';
class WasteRepository{

  final WasteDataProvider dataProvider;

  WasteRepository({required this.dataProvider});

  Future<List<Waste>?> fetchUserWaste(String id,String token){
    return this.dataProvider.fetchUserWaste(id,token);
  }

  Future<List<Waste>?> fetchUserWasteByType(String id, String token, String for_waste, String type) {
    return this.dataProvider.fetchUserWasteByType(id, token,for_waste,type);
  }

  Future<Waste?> createWaste(Waste waste,String token,File file){
    print("function called");
    return this.dataProvider.createWaste(waste:waste,token:token,file:file);
  }

  Future<void> deleteWaste(int id ,String token){
    return this.dataProvider.deleteWaste(id, token);
  }

}