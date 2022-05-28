import 'package:clean_addis_android/data/data_providers/notification_data.dart';
import 'package:clean_addis_android/data/models/notification.dart';


class NotificationRepo {
  NotificationDataProvider dataProvider;
  NotificationRepo({required this.dataProvider});
  Future<List<Notification>?> getNotification(String id, String token) async {
    return this.dataProvider.getNotification(id, token);
  }
}
