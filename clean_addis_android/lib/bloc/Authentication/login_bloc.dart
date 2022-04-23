

import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/bloc/Authentication/login_event.dart';
import 'package:clean_addis_android/bloc/Authentication/login_state.dart';
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';

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
        print(data.access_token);
        print(data.refresh_token);

        yield AuthenticatedState(user: data);
        
      } catch (e){
        AuthenticationFailureState(e.toString());
        print("caught");
      }
    }
  }
}