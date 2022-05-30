import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/data/models/notification.dart';
import 'package:clean_addis_android/data/repositories/notification_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  
  NotificationRepo repo;
  NotificationsBloc({required this.repo}) : super(NotificationsInitial());

  Stream<NotificationsState> mapEventToState(NotificationsEvent event) async*{
    if (event is NotificationCreateEvent){
      try{
        yield NotificationsInitial();
        final _storage = FlutterSecureStorage();
        final user_id = await _storage.read(key: 'id');
        Notifications notifications = Notifications(
          type: 'Waste',
          user: event.user,
          point_to: event.point_to,
        );
        
      }catch(e){
        yield NotificationError(message: e.toString());
      }
    }
  }
}
