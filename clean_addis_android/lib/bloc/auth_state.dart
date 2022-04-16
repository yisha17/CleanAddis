
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
  })



  


  @override
  List<Object> get props => [user];
}


