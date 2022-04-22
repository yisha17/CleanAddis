
import 'package:clean_addis_android/data/models/user.dart';
import 'package:equatable/equatable.dart';



enum UserStatus{
    authenticated,
    unauthenticated
}
class UserState extends Equatable {
  final User? user;
  final UserStatus status;

  

  UserState({

    this.user,
    required this.status
  });

  @override
  
  List<Object?> get props => throw UnimplementedError();

}

class ShortPasswordError extends UserState{
  ShortPasswordError() : super(status: UserStatus.unauthenticated);
 }

class PasswordDoesNotMatchError extends UserState{
  PasswordDoesNotMatchError(): super(status: UserStatus.unauthenticated);
}

class IncorrectEmailFormat extends UserState{
  IncorrectEmailFormat() : super(status: UserStatus.unauthenticated);

}

class NetworkError extends UserState{
  final String error;
  NetworkError(this.error) : super(status: UserStatus.unauthenticated);
}
  
class FieldEmptyError extends UserState{
  FieldEmptyError() : super(status: UserStatus.unauthenticated);
}

class UserLoadingState extends UserState {
  UserLoadingState() : super(status: UserStatus.unauthenticated);
}
  
class UserLoadedState extends UserState{
  final User? user;
  UserLoadedState({this.user}) : super(user:user,status: UserStatus.authenticated);
}





