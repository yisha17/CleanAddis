
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