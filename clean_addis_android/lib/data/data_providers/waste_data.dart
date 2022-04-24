

import 'dart:convert';

import 'package:clean_addis_android/data/models/waste.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:http/http.dart' as http;



class WasteDataProvider{

  Future<List<Waste>?> fetchUserWaste(String user_id) async{
    final response = await http.get(Uri.http(base_url,'$user_waste_path/$user_id'));

    if (response.statusCode == 200){
      final waste = jsonDecode(response.body) as List;
      try {
        List<Waste> wasteList =
            waste.map((e) => Waste.fromJSON(e)).toList();

        return wasteList;
      } catch (err) {
        print(err);
      }
    }else{
      throw Exception('Could not fetch waste');
    }
  }


  Future<List<Waste>?> fetchAllWaste() async {
    final response =
        await http.get(Uri.http(base_url, user_waste_path));

    if (response.statusCode == 200) {
      final waste = jsonDecode(response.body) as List;
      try {
        List<Waste> wasteList = waste.map((e) => Waste.fromJSON(e)).toList();

        return wasteList;
      } catch (err) {
        print(err);
      }
    } else {
      throw Exception('Could not fetch waste');
    }
  }

  Future<Waste> singleItem(String id) async {
    final response = await http.get(Uri.http(base_url, '$user_waste_path/$id'));
    if (response.statusCode == 200) {
      return Waste.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can't get waste");
    }
  }
}