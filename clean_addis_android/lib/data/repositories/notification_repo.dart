import 'package:clean_addis_android/data/data_providers/notification_data.dart';
import 'package:clean_addis_android/data/models/notification.dart';


class NotificationRepo {
  NotificationDataProvider dataProvider;
  NotificationRepo({required this.dataProvider});
  Future<List<Notifications>?> getNotification(String id, String token) async {
    return this.dataProvider.getNotification(id, token);
  }

  Future<void> notifySeller(String token, int owner,int waste_id) async{
    return this.dataProvider.notifySeller(token,owner,waste_id);
  }
}
