part of 'report_bloc.dart';



class ReportState extends Equatable {
  final Report? report;
  final List<Report?>? reportList;
  ReportState({this.report,this.reportList});
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

class ReportListState extends ReportState{
  final List<Report> reportList;
  ReportListState([this.reportList = const[]]);
  @override
  List<Object?> get props => [this.reportList];
}


