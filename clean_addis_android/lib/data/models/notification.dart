class Notifications {
  final int? id;
  final int? user;
  final bool? isSeen;
  final String? type;
  final int? buyer;
  final String? waste_name;
  final String? report_title;
  final String? post_date;
  final String? created_at;

  Notifications(
      {this.id,
      this.user,
      this.buyer,
      this.type,
      this.created_at,
      this.waste_name,
      this.report_title,
      this.post_date,
      this.isSeen});

  factory Notifications.fromJSON(Map<String, dynamic> jsonMap) {
    final notification = Notifications(
      id: jsonMap['id'],
      user: jsonMap['owner_id'],
      waste_name: jsonMap['waste_name'],
      report_title: jsonMap['report_title'],
      created_at: jsonMap['created_at'],
      type: jsonMap['notification_type'],
      buyer: jsonMap['buyer_id'],
      isSeen: jsonMap['is_seen'],
    );
    return notification;
  }
}
