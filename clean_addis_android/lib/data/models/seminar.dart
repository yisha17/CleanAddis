

class Seminar{
  final int? id;
  final String? link;
  final String? title;
  final String? type;
  final String? image;
  final String? postdate;
  final bool? isSeen;

  Seminar({this.id,this.title, this.postdate,this.link, this.type, this.image,this.isSeen});

  factory Seminar.fromJSON(Map<String,dynamic> jsonMap){
    final seminar = Seminar(
      id: jsonMap['id'],
      title: jsonMap['seminarTitle'],
      postdate: jsonMap['fromDate'],
      link: jsonMap['link'],
      type: jsonMap['seminarType'],
      image : jsonMap['imageLink'],
      isSeen: jsonMap['isSeen']
     );
     return seminar;
  }
}