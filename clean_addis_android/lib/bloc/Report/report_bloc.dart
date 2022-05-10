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
  ReportBloc(this.reportRepository) : super(ReportState()) {
    on<ReportCreateEvent>((event, emit) async* {
      try{
        emit(ReportLoadingState());
        final _storage = FlutterSecureStorage();
        final user_id = await _storage.read(key: 'id');

        Report report = Report(
          title: event.title,
          description: event.description,
          longitude: event.longitude,
          latitude: event.latitude,
        );

        final token = await _storage.read(key: 'token');
        final data = await reportRepository.createReport(report, token!, event.image!);
        
        emit(ReportCreatedState(report: data!));
      }catch(e){

      }
    });
  }
}
