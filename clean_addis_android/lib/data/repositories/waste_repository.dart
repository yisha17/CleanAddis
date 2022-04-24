
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/models/waste.dart';
class WasteRepository{

  final WasteDataProvider dataProvider;

  WasteRepository({required this.dataProvider});

  Future<List<Waste>?> fetchUserWaste(String id){
    return this.dataProvider.fetchUserWaste(id);
  }

}