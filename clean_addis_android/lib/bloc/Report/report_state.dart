part of 'report_bloc.dart';



class ReportState extends Equatable {
  final Report? report;
  ReportState({this.report});
   @override
  List<Object?> get props => throw UnimplementedError();
}

class ReportLoadingState extends ReportState {
  @override
  List<Object?> get props => [];
}

class ReportCreatedState extends ReportState {
  final Report report;
  ReportCreatedState({required this.report});
  @override
  List<Object?> get props => [this.report];
}


class ReportErrorState extends ReportState{
  final String message;
  ReportErrorState({required this.message});
  @override
  List<Object?> get props => [this.message];
}


