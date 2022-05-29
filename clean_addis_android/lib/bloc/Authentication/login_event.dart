
import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  const LoginEvent();
}



class Authenticate extends LoginEvent{
   final String? username;
   final String? password;

  Authenticate({this.username,this.password});

  @override
  List<Object?> get props => [this.username,this.password];
}

class LogoutEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}


class UserProfileEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}

class UserUpdateEvent extends LoginEvent {
  final int id;
  final String username;
  final File? profile;
  final String? email;
  final String? address;
  final String? phone;
  UserUpdateEvent({
    required this.id,
    required this.username,
    this.profile,
    this.email,
    this.address,
    this.phone,
  });
  @override
  List<Object?> get props => [id,username,profile,email,address,phone];

}

class SellerProfileEvent extends LoginEvent{
  final int seller;
  SellerProfileEvent({required this.seller});
  @override
  List<Object?> get props => [this.seller];
}
