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
        final token = await _storage.read(key: 'token');
        
        try{
           await repo.notifySeller(token!,event.owner, event.waste_id);
        }catch(e){
          print(e.toString());
        }
       
        
        yield NotificationCreated();
        
      }catch(e){
        yield NotificationError(message: e.toString());
      }
    }

    if (event is NotificationPageEvent){
      try{
        yield NotificationsInitial();
        final _storage = FlutterSecureStorage();
        final token = await _storage.read(key: 'token');
        final id = await _storage.read(key: 'id');

        final data = await repo.getNotification(id!, token!);

        yield NotificationListLoaded(data!);

      }catch(e){
        yield NotificationError(message: e.toString());
      }
    }

    if (event is NotificationIsSeen){
     try{ yield NotificationsInitial();
      final _storage = FlutterSecureStorage();
      final token = await _storage.read(key: 'token');
      await repo.isSeen(token!, event.notification_id.toString());
      yield NotificationRemoved();}
      catch(e){
        print("here is the error");
        print(e.toString());
      }
    }
  }



}
