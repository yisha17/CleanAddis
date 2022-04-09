import 'package:clean_addis_android/data/models/address.dart';
import 'package:flutter/cupertino.dart';

class Company {
  final int? id;
  final String? company_name;
  final String? company_email;
  final String? password;
  final String? role;
  final Image? logo;
  final Address? address;

  Company(
      {this.id,
      this.company_name,
      this.company_email,
      this.password,
      this.role,
      this.logo,
      this.address});
}
