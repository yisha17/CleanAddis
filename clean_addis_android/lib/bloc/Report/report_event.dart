part of 'report_bloc.dart';

@immutable
abstract class ReportEvent extends Equatable{
  const ReportEvent();
}

class ReportCreateEvent extends ReportEvent{
  final String? title;
  final String? description;
  final String? longitude;
  final String? latitude;
  final File? image;


  ReportCreateEvent({
    this.title,
    this.description,
    this.longitude,
    this.latitude,
    this.image
  });

  @override
  List<Object?> get props => [title,description,image,longitude,latitude];

}

class ReportEditEvent extends ReportEvent{
  final int id;
  final String? title;
  final String? description;

  ReportEditEvent({
    required this.id,
    this.title,
    this.description,
  });

  @override
  List<Object?> get props => [title,description];
}


class ReportDeleteEvent extends ReportEvent{
  final String id;

  ReportDeleteEvent({
    required this.id
  });
  
   @override
  List<Object?> get props => [id];
}


class ReportListEvent extends ReportEvent{
  @override
  List<Object?> get props => [];
}

class ReportDetailEvent extends ReportEvent{
  final int id;
  ReportDetailEvent({required this.id});
  @override
  List<Object?> get props => [this.id];
}
