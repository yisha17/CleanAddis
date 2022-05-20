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

  Future<void> deleteReport(int id, String token) {
    return this.dataProvider.deleteReport(id, token);
  }
}
