

import 'package:clean_addis_android/data/data_providers/seminar_data.dart';
import 'package:clean_addis_android/data/models/seminar.dart';

class SeminarRepo{
  SeminarDataProvider dataProvider;
  SeminarRepo(this.dataProvider);

  Future<List<Seminar>?> getSeminar(String token){
    return this.dataProvider.getSeminar(token);
  }
}