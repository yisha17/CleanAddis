part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState extends Equatable {}

class NotificationsInitial extends NotificationsState {
   @override
  List<Object?> get props => [];
}

class NotificationLoaded extends NotificationsState {
  final Notifications notification;
  NotificationLoaded({required this.notification});
   @override
  List<Object?> get props => [notification];
}

class NotificationListLoaded extends NotificationsState{
  final List<Notifications> notifications;

  NotificationListLoaded([this.notifications = const[]]);

    @override
  List<Object?> get props => [notifications];
}

class NotificationCreated extends NotificationsState{
  @override
  List<Object?> get props => []; 
}

class NotificationError extends NotificationsState{
  final String message;
  NotificationError({required this.message});
   @override
  List<Object?> get props => [this.message];
}


class NotificationRemoved extends NotificationsState {
  @override
  List<Object?> get props => [];
}
