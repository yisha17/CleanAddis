
import 'package:clean_addis_android/data/models/user.dart';
import 'package:equatable/equatable.dart';



enum UserStatus{
    authenticated,
    unauthenticated
}
class UserState extends Equatable {
  final User? user;
 

  UserState({

    this.user,
  });

  @override
  
  List<Object?> get props => throw UnimplementedError();

}

class ShortPasswordError extends UserState{
  ShortPasswordError() : super();
 }

class PasswordDoesNotMatchError extends UserState{
  PasswordDoesNotMatchError(): super();
}

class IncorrectEmailFormat extends UserState{
  IncorrectEmailFormat() : super();

}

class NetworkError extends UserState{
  final String error;
  NetworkError(this.error) : super();
}
  

class UserLoadingState extends UserState {
  UserLoadingState() : super();
}
  
class UserLoadedState extends UserState{
  final User? user;
  UserLoadedState({this.user}) : super(user:user);
}





