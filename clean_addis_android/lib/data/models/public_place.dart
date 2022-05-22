class PublicPlace {
  final int? id;
  final int? rating;
  final String? name;
  final String? type;
  final String? longitude;
  final String? latitude;

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
        latitude: jsonMap['latitude']);
    return result;
  }
}
