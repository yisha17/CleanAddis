

import 'package:clean_addis_android/data/data_providers/public_place_data.dart';
import 'package:clean_addis_android/data/models/public_place.dart';

class PublicPlaceRepository{
  PublicPlaceDataProvider dataProvider;

  PublicPlaceRepository({required this.dataProvider});

  Future<List<PublicPlace>?> getPublicPlaceByType(String token,String type){
    return this.dataProvider.getPublicPlaceByType(type, token);
  }
}