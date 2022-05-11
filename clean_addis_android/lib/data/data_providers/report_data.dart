import 'dart:convert';
import 'dart:io';
import 'package:clean_addis_android/data/models/report.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:clean_addis_android/strings.dart';
import 'package:http_parser/http_parser.dart';

class ReportDataProvider{
  var dio = Dio();

  Future<Report> createReport({required Report report,required String token, File? file}) async{
    dio.options.headers["authorization"] = "JWT ${token}";
    String imageFile = file!.path.split('/').last;
    FormData formData = FormData.fromMap({
      'reportTitle': report.title,
      'reportDescription': report.description,
      'reportedBy': report.reportedBy,
      'longitude': report.longitude,
      'latitude': report.latitude,
      'image': await MultipartFile.fromFile(file.path,
          filename: imageFile, contentType: new MediaType("image", "jpg"))
    });
    
    print(formData);
    final response =  await dio.post('$full_base_url$report_path', data: formData);

    Report report_returned = Report.fromJSON(response.data);

     if (response.statusCode == 201) {
      return report_returned;
    } else {
      throw Exception('error');
    }
  }


   Future<List<Report>?> fetchUserReport(String user_id, String token) async {
    final response = await http
        .get(Uri.http(base_url, '$user_report_path$user_id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    });

    if (response.statusCode == 200) {
      final report = jsonDecode(response.body) as List;
      try {
        List<Report> wasteList = report.map((e) => Report.fromJSON(e)).toList();

        return wasteList;
      } catch (err) {
        print(err);
      }
    } else {
      throw Exception('Could not fetch waste');
    }
    return null;
  }

  Future<Report> singleReport(String id,String token) async {
    final response = await http.get(Uri.http(base_url, '$report_path/$id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'JWT $token',
    });
    if (response.statusCode == 200) {
      return Report.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception("error");
    }
  }


  Future<void> deleteReport(int id,String token) async{
    final response = await http.delete(Uri.http(base_url, '$user_report_path/$id'));

    if (response == 204){
      print("deleted");
    }else{
      throw Exception('error');
    }
  }
}