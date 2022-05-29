import 'package:clean_addis_android/data/models/address.dart';
import 'waste.dart';

class User {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final String? profile;
  final String? phone;
  final String? address;
  final List<Waste?>? waste;
  final String? access_token;
  final String? refresh_token;
  final int? report_count;
  final int? donate_count;
  final int? sell_count;
  //device id

  User({
    this.id,
    this.username,
    this.email,
    this.password,
    this.role,
    this.profile,
    this.phone,
    this.address,
    this.waste,
    this.access_token,
    this.refresh_token,
    this.report_count,
    this.sell_count,
    this.donate_count
  });


  factory User.fromJSON(Map<String,dynamic>jsonMap){
    final result = User(
      id: jsonMap['id'],
      username: jsonMap['username'],
      email: jsonMap['email'],
      password: jsonMap['password'],
      role : jsonMap['role'],
      profile: jsonMap['profile'] ?? '',
      phone: jsonMap['phone'] ?? '',
      access_token: jsonMap['access'],
      refresh_token: jsonMap['refresh'],
      address: jsonMap['address'],
      waste: jsonMap['waste'],
      report_count : jsonMap['report_count'],
      sell_count:jsonMap['sell_count'],
      donate_count: jsonMap['donation_count']
    );
    return result;
  }
}
