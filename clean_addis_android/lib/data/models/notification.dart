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
  final String? buyer_name;
  final String? owner_name;
  final String? address;
  final String? message;
  final String? buyer_phone;
  Notifications(
      {this.id,
      this.user,
      this.buyer,
      this.type,
      this.created_at,
      this.buyer_name,
      this.owner_name,
      this.waste_name,
      this.report_title,
      this.post_date,
      this.message,
      this.address,
      this.isSeen,
      this.buyer_phone});

  factory Notifications.fromJSON(Map<String, dynamic> jsonMap) {
    final notification = Notifications(
      id: jsonMap['id'],
      user: jsonMap['owner_id'],
      waste_name: jsonMap['waste_name'],
      report_title: jsonMap['report_title'],
      created_at: jsonMap['created_at'],
      type: jsonMap['notification_type'],
      buyer: jsonMap['buyer_id'],
      address:jsonMap['address'],
      buyer_name:jsonMap['buyer_name'],
      owner_name: jsonMap['owner_name'],
      isSeen: jsonMap['is_seen'],
      message: jsonMap['notification_body'],
      buyer_phone: jsonMap['buyer_phone']
    );
    return notification;
  }
}
