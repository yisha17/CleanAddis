import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
}

class LoadUser extends SignupEvent {
  final String? username;
  final String? email;
  final String? password;
  final String? re_password;
  final String? phone;
  final String? address;

  LoadUser(
      {this.username,
      this.email,
      this.password,
      this.re_password,
      this.phone,
      this.address});

  @override
  List<Object?> get props => [
        this.username,
        this.email,
        this.password,
        this.re_password,
        this.phone,
        this.address
      ];
}

class ProfileUpdate extends SignupEvent {
  final String? username;
  final String? email;
  final String? password;
  final String? phone;
  final File? profile;
  ProfileUpdate({
    this.username,
    this.email,
    this.password,
    this.phone,
    this.profile,
  });

  @override
  List<Object?> get props =>
      [this.username, this.email, this.password, this.phone, this.profile];
}
