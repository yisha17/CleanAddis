import 'dart:convert';
import 'dart:io';

import 'package:clean_addis_android/data/models/waste.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class WasteDataProvider {
  var dio = Dio();

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
    return null;
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
    return null;
  }

  Future<Waste> singleItem(String id) async {
    final response = await http.get(Uri.http(base_url, '$user_waste_path/$id'));
    if (response.statusCode == 200) {
      return Waste.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("can't get waste");
    }
  }

  Future<Waste> createWaste(
      {required Waste waste, required String token, File? file}) async {
    // final request =
    //     await http.MultipartRequest("POST", Uri.parse('$full_base_url/$waste_path'));

    // request.headers.addAll({"Authorization": "JWT $token"});
    // request.files.add(await http.MultipartFile.fromPath("image", file!.path));
    // request.fields.forEach((key, dynamic value) {
    //   request.fields[key] = value;
    // });

    // request.fields['waste_name'] = waste.waste_name!;
    // request.fields['waste_type'] = waste.waste_type!;
    // request.fields['for_waste'] = waste.for_waste!;
    // request.fields['seller'] = waste.seller as String;
    // request.fields['waste_name'] = waste.waste_name!;
    // request.fields['metric'] = waste.metric!;
    // request.fields['quantity'] = waste.quantity! as String;
    // request.fields['price_per_unit'] = waste.price_per_unit as String;
    // request.fields['location'] = waste.location!;
    // request.fields['description'] = waste.description!;

    // var response = await request.send();
    // var responsed = await http.Response.fromStream(response);
    // final waste_ret = json.decode(responsed.body);
    // print(response.statusCode);
    // print(request.fields['waste_name']);

    // if (response.statusCode == 200) {
    //   return waste_ret;
    // } else {
    //   throw Exception('error');
    // }
    dio.options.headers["authorization"] = "JWT ${token}";
  print('yishak');
    FormData formData = FormData.fromMap({
      'waste_name': waste.waste_name!,
      'waste_type': waste.waste_type!,
      'for_waste': waste.for_waste!,
      'seller': waste.seller,
      'metric': waste.metric!,
      'quantity': waste.quantity!,
      'price_per_unit': waste.price_per_unit,
      'location': waste.location!,
      'description': waste.description!,
      'image' : await MultipartFile.fromFile( file!.path)
    });
    
    print(formData.fields);
    print(formData.toString());

    final response = await dio.post('$full_base_url/$waste_path',data: formData);
  print(response.statusCode);
    Waste waste_returned = json.decode(response.data);
    print(response.statusCode);
    print(waste_returned.image);

    if (response.statusCode == 200) {
      return waste_returned;
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

  Future<void> deleteWaste(int id, String token) async {
    final response =
        await http.delete(Uri.http(base_url, '$user_waste_path/$id'));

    if (response == 204) {
      print("deleted");
    } else {
      throw ('error');
    }
  }
}
