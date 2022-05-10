


class Report{
  final int? id;
  final int? reportedBy;
  final DateTime? post_date;
  final String? title;
  final String? description;
  final String? image;
  final bool? isResolved;
  final double? longitude;
  final double? latitude;

  Report({
    this.id,
    this.reportedBy,
    this.post_date,
    this.title,
    this.image,
    this.description,
    this.isResolved,
    this.latitude,
    this.longitude,
  });

  factory Report.fromJSON(Map<String,dynamic> jsonMap){
    final result = Report(
      id: jsonMap['id'],
      reportedBy: jsonMap['reportedBy'],
      post_date: jsonMap['post_date'],
      title: jsonMap['reportTitle'],
      description: jsonMap['reportDescription'],
      isResolved: jsonMap['isResolved'],
      image : jsonMap['image'],
      longitude:jsonMap['longitude'],
      latitude: jsonMap['latitiude'],
    );
    return result;
  }
}