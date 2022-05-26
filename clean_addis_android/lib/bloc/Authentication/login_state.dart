import 'package:clean_addis_android/data/models/user.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final User? user;
  LoginState({this.user});
  @override
  List<Object?> get props =>[this.user];
}

class UserLoadingState extends LoginState {
}

class AuthenticationFailureState extends LoginState{
 final String e;
 AuthenticationFailureState(this.e); 
 @override
  List<Object> get props => [this.e];
}

class AuthenticatedState extends LoginState {
  final User user;
  
  AuthenticatedState({required this.user});
  @override
  List<Object> get props => [user];
}

class UserDetailState extends LoginState{

  final User user;
  UserDetailState({required this.user});
  @override
  List<Object> get props => [user];
}


  

