import 'package:clean_addis_android/data/models/address.dart';
import 'package:flutter/material.dart';

class User {
  final int? id;
  final String? username;
  final String? email;
  final String? role;
  final Image? profile;
  final String? phone;
  final Address? address;
  //device id

  User({
    this.id,
    this.username,
    this.email,
    this.role,
    this.profile,
    this.phone,
    this.address,
  });
}
