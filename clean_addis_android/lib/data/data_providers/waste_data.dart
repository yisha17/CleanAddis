import 'dart:convert';
import 'dart:io';

import 'package:clean_addis_android/data/models/waste.dart';
import 'package:clean_addis_android/strings.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

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

  Future<List<Waste>?> fetchUserWasteByType(
      String user_id, String token, String for_waste, String type) async {
    final response = await http.get(
        Uri.http(base_url, '$user_waste_path$user_id/$for_waste/$type'),
        headers: {
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
    dio.options.headers["authorization"] = "JWT ${token}";

    String imageFile = file!.path.split('/').last;
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
      'image': await MultipartFile.fromFile(file.path,
          filename: imageFile, contentType: new MediaType("image", "jpg"))
    });

    try {
      final response =
          await dio.post('$full_base_url/$waste_path', data: formData);
      print(response.statusCode);

      Waste waste_returned = Waste.fromJSON(response.data);

      print(response.statusCode);
      print(waste_returned.image);

      if (response.statusCode == 201) {
        return waste_returned;
      } else {
        throw Exception('error');
      }
    } catch (e) {
      print('printing');
      print(e.toString());
      throw Exception('cant create waste');
    }
  }

  Future<Waste> updateWaste(
      {required String id,required Waste waste, required String token, File? file}) async {
    dio.options.headers["authorization"] = "JWT ${token}";

    String imageFile = file!.path.split('/').last;
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
      'image': await MultipartFile.fromFile(file.path,
          filename: imageFile, contentType: new MediaType("image", "jpg"))
    });

    try {
      // api/waste/<int:pk>/update
      final response =
          await dio.patch('$full_base_url/$waste_path$id/update', data: formData);
      print(response.statusCode);

      Waste waste_returned = Waste.fromJSON(response.data);

      if (response.statusCode == 201) {
        return waste_returned;
      } else {
        throw Exception('error');
      }
    } catch (e) {
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

Future<List<Waste>?> availableWasteByType(String token,String type) async{
  final response = await http.get(Uri.http(base_url,'$waste_path$type/'),
  headers: {
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

}
