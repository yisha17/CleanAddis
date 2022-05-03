import 'dart:convert';
import 'dart:io';
import 'package:clean_addis_android/data/models/report.dart';
import 'package:http/http.dart' as http;
import 'package:clean_addis_android/strings.dart';

class ReportDataProvider{

  Future<Report> createReport({required Report report,required String token, File? file}) async{
    final request = 
      await http.MultipartRequest("POST",Uri.parse('$full_base_url/$report_path'));
      request.headers.addAll({"Authorization": "JWT $token"});
      request.files.add(await http.MultipartFile.fromPath("image", file!.path));
      request.fields.forEach((key, dynamic value) {
      request.fields[key] = value;
    });
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final report = json.decode(responsed.body);

    if (response.statusCode == 200) {
      return report;
    } else {
      throw Exception('error');
    }
  }

  Future<Report> singleReport(String id) async {
    final response = await http.get(Uri.http(base_url, '$user_report_path/$id'));
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