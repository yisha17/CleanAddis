
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable{
  const SignupEvent();
}

class LoadUser extends SignupEvent{
  final String? username;
  final String? email;
  final String? password;
  final String? re_password;

  LoadUser({this.username, this.email, this.password, this.re_password});

  @override
  List<Object?> get props => [this.username,this.email,this.password,this.re_password];
}

class UsernameChanged extends SignupEvent {
  final String username;
  const UsernameChanged(this.username);

  @override
  List<Object> get props => [this.username];
}

class EmailChanged extends SignupEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [this.email];
}


class PasswordChanged extends SignupEvent {
  final String password;
  const PasswordChanged(this.password);

  @override
  List<Object> get props => [this.password];
}
