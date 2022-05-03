import 'dart:convert';
import 'dart:io';

import 'package:clean_addis_android/data/models/waste.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:http/http.dart' as http;

class WasteDataProvider {
  Future<List<Waste>?> fetchUserWaste(String user_id, String token) async {
    final response = await http
        .get(Uri.http(base_url, '$user_waste_path$user_id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    });

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

  Future<List<Waste>?> fetchAllWaste() async {
    final response = await http.get(Uri.http(base_url, user_waste_path));

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

  Future<Waste> createWaste({required Waste waste,required String token, File? file}) async {
    final request =
        await http.MultipartRequest("POST", Uri.parse('$full_base_url/$waste_path'));
    request.headers.addAll({"Authorization": "JWT $token"});
    request.files.add(await http.MultipartFile.fromPath("image", file!.path));
    request.fields.forEach((key, dynamic value) {
      request.fields[key] = value;
    });

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final waste = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return waste;
    } else {
      throw Exception('error');
    }
  }


   Future<Waste> updateWaste(
      {required Waste waste, required String token, File? file}) async {
    final request = await http.MultipartRequest(
        "PATCH", Uri.parse('$full_base_url/$waste_path'));
    request.headers.addAll({"Authorization": "JWT $token"});
    request.files.add(await http.MultipartFile.fromPath("image", file!.path));
    request.fields.forEach((key, dynamic value) {
      request.fields[key] = value;
    });

    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final waste = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return waste;
    } else {
      throw Exception('error');
    }
  }

  Future<void> deleteWaste(int id,String token) async{
    final response = await http.delete(Uri.http(base_url, '$user_waste_path/$id'));

    if (response == 204){
      print("deleted");
    }else{
      throw('error');
    }
  }
}
