part of 'notifications_bloc.dart';

@immutable
abstract class NotificationsState extends Equatable {}

class NotificationsInitial extends NotificationsState {
   @override
  List<Object?> get props => [];
}

class NotificationLoaded extends NotificationsState {
  final Notification notification;
  NotificationLoaded({required this.notification});
   @override
  List<Object?> get props => [notification];
}
