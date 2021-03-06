import 'dart:io';

import 'package:clean_addis_android/data/data_providers/report_data.dart';
import 'package:clean_addis_android/data/models/report.dart';

class ReportRepository {
  final ReportDataProvider dataProvider;

  ReportRepository({required this.dataProvider});

  Future<List<Report>?> fetchUserReport(String id, String token) {
    return this.dataProvider.fetchUserReport(id, token);
  }

  Future<Report?> createReport(Report report, String token, File file) {
    return this.dataProvider.createReport(report: report, token: token, file: file);
  }


  Future<Report?> singleReport(String id, String token, ) {
    return this
        .dataProvider
        .singleReport(id,token);
  }

  Future<void> deleteReport(int id, String token) {
    return this.dataProvider.deleteReport(id, token);
  }

  Future<Report> updateReport({required Report report, required String id, required String token}){
    return this.dataProvider.updateReport(report: report, token: token, id: id);
  }
}
