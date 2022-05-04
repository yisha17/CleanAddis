class PublicPlace {
  final int? id;
  final int? rating;
  final String? name;
  final String? type;
  final double? longitude;
  final double? latitude;

  PublicPlace({
    this.id,
    this.rating,
    this.name,
    this.type,
    this.longitude,
    this.latitude,
  });

  factory PublicPlace.fromJSON(Map<String, dynamic> jsonMap) {
    final result = PublicPlace(
        id: jsonMap['id'],
        rating: jsonMap['rating'],
        name: jsonMap['name'],
        type: jsonMap['type'],
        longitude: jsonMap['longitude'],
        latitude: jsonMap['latitiude']);
    return result;
  }
}
