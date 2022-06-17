part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent extends Equatable {}

class NotificationPageEvent extends NotificationsEvent {
  
  @override
  List<Object?> get props => [];
}

class NotificationCreateEvent extends NotificationsEvent {

  final int owner;
  final int waste_id;
  NotificationCreateEvent(
      { required this.owner,required this.waste_id});

   @override
  List<Object?> get props => [owner];    
}



