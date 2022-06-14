part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsEvent extends Equatable {}

class NotificationPageEvent extends NotificationsEvent {
  final int id;
  NotificationPageEvent({required this.id});
  @override
  List<Object?> get props => [this.id];
}

class NotificationCreateEvent extends NotificationsEvent {

  final int owner;

  NotificationCreateEvent(
      { required this.owner});

   @override
  List<Object?> get props => [owner];    
}


