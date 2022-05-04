


class Report{
  final int? id;
  final int? reportedBy;
  final DateTime? post_date;
  final String? title;
  final String? description;
  final bool? isResolved;
  final double? longtiude;
  final double? latitude;

  Report({
    this.id,
    this.reportedBy,
    this.post_date,
    this.title,
    this.description,
    this.isResolved,
    this.latitude,
    this.longtiude,
  });

  factory Report.fromJSON(Map<String,dynamic> jsonMap){
    final result = Report(
      id: jsonMap['id'],
      reportedBy: jsonMap['reportedBy'],
      post_date: jsonMap['post_date'],
      title: jsonMap['title'],
      description: jsonMap['description'],
      isResolved: jsonMap['isResolved'],
      longtiude:jsonMap['longitude'],
      latitude: jsonMap['latitiude'],
    );
    return result;
  }
}