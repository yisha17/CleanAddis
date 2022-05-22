import 'dart:convert';

import 'package:clean_addis_android/strings.dart';
import 'package:http/http.dart' as http;
import '../models/public_place.dart';

class PublicPlaceDataProvider {
  
  Future<List<PublicPlace>?> getPublicPlaceByType(
      String type, String token) async {
    final response =
        await http.get(Uri.http(base_url, 'api/publicplace/list/'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    });

    if (response.statusCode == 200) {
      final public_place = jsonDecode(response.body) as List;

      try {
        List<PublicPlace> publicPlaceList =
            public_place.map((e) => PublicPlace.fromJSON(e)).toList();
        return publicPlaceList;
      } catch (e) {
        print(e);
      }
    } else {
      throw Exception('Error');
    }
    return null;
  }
}
