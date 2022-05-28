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
  final int user;
  final int point_to;
  final String type;

  NotificationCreateEvent(
      {required this.user, required this.point_to, required this.type});

   @override
  List<Object?> get props => [user,point_to,type];    
}
