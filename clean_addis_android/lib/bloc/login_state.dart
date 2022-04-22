import 'package:clean_addis_android/data/models/user.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserLoadingState extends LoginState {
  UserLoadingState() : super();
}

class GetErrorState extends LoginState{
  
}

class UserLoadedState extends LoginState {
  final User? user;
  UserLoadedState({this.user}) : super();
}
