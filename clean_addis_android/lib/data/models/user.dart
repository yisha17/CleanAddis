import 'package:clean_addis_android/data/models/address.dart';
import 'package:flutter/material.dart';

import 'waste.dart';

class User {
  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? role;
  final Image? profile;
  final String? phone;
  final Address? address;
  final List<Waste?>? waste;
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
    this.waste
  });


  factory User.fromJSON(Map<String,dynamic>jsonMap){
    final result = User(
      id: jsonMap['id'],
      username: jsonMap['username'],
      email: jsonMap['email'],
      password: jsonMap['password'],
      role : jsonMap['role'],
      profile: jsonMap['profile'],
      phone: jsonMap['phone'],
      address: jsonMap['address'],
      waste: jsonMap['waste']
    );
    return result;
  }
}
