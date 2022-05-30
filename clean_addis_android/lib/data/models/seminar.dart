

class Seminar{
  final int? id;
  final String? link;
  final String? type;
  final String? image;
  final bool? isSeen;

  Seminar({this.id, this.link, this.type, this.image,this.isSeen});

  factory Seminar.fromJSON(Map<String,dynamic> jsonMap){
    final seminar = Seminar(
      id: jsonMap['id'],
      link: jsonMap['link'],
      type: jsonMap['seminarType'],
      image : jsonMap['image'],
      isSeen: jsonMap['isSeen']
     );
     return seminar;
  }
}