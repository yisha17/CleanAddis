import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/report.dart';
import 'package:clean_addis_android/data/repositories/report_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportRepository reportRepository;
  ReportBloc(this.reportRepository) : super(ReportState());

 

  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is ReportCreateEvent) {
      try {
        yield ReportLoadingState();
        print('here');
        final _storage = FlutterSecureStorage();
        final user_id = await _storage.read(key: 'id');

        Report report = Report(
            title: event.title,
            description: event.description,
            longitude: event.longitude,
            latitude: event.latitude,
            reportedBy: int.parse(user_id!));
        
        print(report.reportedBy);
        print(report.latitude);
        print(report.longitude);
        print(report.description);

        final token = await _storage.read(key: 'token');
        final data =
            await reportRepository.createReport(report, token!, event.image!);

        yield ReportCreatedState(report: data!);
      } catch (e) {
        yield ReportErrorState(message: e.toString());
        
      }
    }

    if (event is ReportListEvent){
      
      try{
        yield ReportLoadingState(); 
        final _storage = FlutterSecureStorage();
        final user_id = await _storage.read(key: 'id');
        String? token = await _storage.read(key: 'token');
        final report = await reportRepository.fetchUserReport(user_id!, token!);
        await Future.delayed(Duration(seconds: 3));
        yield ReportListState(report!);
      }catch(e){
        yield ReportErrorState(message: e.toString());
      }
    }
    
  }
}
