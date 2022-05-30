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

class NotificationError extends NotificationsState{
  final String message;
  NotificationError({required this.message});
   @override
  List<Object?> get props => [this.message];
}
