

import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/bloc/Authentication/login_event.dart';
import 'package:clean_addis_android/bloc/Authentication/login_state.dart';
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:clean_addis_android/helpers/device_id.dart';
import 'package:clean_addis_android/presentation/UserProfile.dart';
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
        await _storage.write(key: 'password', value: event.password);
        getToken();
        print('here');
        print(getId());
        await userRepository.createDeviceInfo();
        yield AuthenticatedState(user: data);
        
        

      } catch (e){
        
        yield AuthenticationFailureState(e.toString());
        
      }
    }

    if (event is UserProfileEvent){
      try{
        yield UserLoadingState();
        final _storage = FlutterSecureStorage();
        final user_id = await _storage.read(key: 'id');
        final token = await _storage.read(key: 'token');
        final data = await userRepository.singleUser(user_id!, token!);
        print(data);
        yield UserDetailState(user: data!);
      }catch(e){
        yield AuthenticationFailureState(e.toString());
      }
    }
    if (event is SellerProfileEvent) {
      try {
        yield UserLoadingState();
        final _storage = FlutterSecureStorage();
        final user_id = await _storage.read(key: 'id');
        final token = await _storage.read(key: 'token');
        final data = await userRepository.singleUser(user_id!, token!);
        print(data);
        yield SellerLoadedState(user: data!);
      } catch (e) {
        yield AuthenticationFailureState(e.toString());
      }
    }

    if (event is UserUpdateEvent){
      try{
        print("update d event");
        yield UserLoadingState();
        final _storage = FlutterSecureStorage();
        final token = await _storage.read(key: 'token');
        
        User user = User(
          username: event.username,
          email: event.email,
          address: event.address,
          phone: event.phone
        );
        print('this.is event profile');
        print(event.profile);
        
        final data = await userRepository.updateProfile(user, event.id.toString(), token!, event.profile);
        yield UserDetailState(user: data!); 


      }catch(e){
        yield AuthenticationFailureState(e.toString());
      }
    }
  }
}