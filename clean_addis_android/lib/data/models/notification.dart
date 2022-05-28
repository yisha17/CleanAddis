class Notification {
  final int? id;
  final int? user;
  final bool? isSeen;
  final String? type;
  final String? post_date;
  final int? point_to;

  Notification(
      {this.id,
      this.user,
      this.type,
      this.post_date,
      this.point_to,
      this.isSeen});

  factory Notification.fromJSON(Map<String, dynamic> jsonMap) {
    final notification = Notification(
      id: jsonMap['id'],
      user: jsonMap['user'],
      type: jsonMap['notificationType'],
      point_to: jsonMap['point_to'],
      isSeen: jsonMap['isSeen'],
    );
    return notification;
  }
}
