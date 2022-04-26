

import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/bloc/Authentication/login_event.dart';
import 'package:clean_addis_android/bloc/Authentication/login_state.dart';
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  UserRepository userRepository;
  LoginBloc(this.userRepository):super(LoginState());


   void onLogin(String username, String password) {
    add(Authenticate(
      username: username,
      password: password,
    ));
  }

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is Authenticate){
      try{
        yield UserLoadingState();
        await Future.delayed(Duration(seconds: 3));
        User user = User(
          username: event.username?.trim().toString(),
          password: event.password?.trim().toString(),
        );
        final data = await userRepository.login(user);
        
       final _storage = const FlutterSecureStorage();
        Map<String, dynamic> payload = Jwt.parseJwt(data.access_token!);
        await _storage.write(key: 'id', value: payload['user_id'].toString());
        await _storage.write(key: 'token', value:data.access_token);
        await _storage.write(key: 'name', value: event.username);
      
        yield AuthenticatedState(user: data);

      } catch (e){
        
        yield AuthenticationFailureState(e.toString());
        
      }
    }
  }
}