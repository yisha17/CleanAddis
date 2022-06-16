import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/bloc/Signup/auth_event.dart';
import 'package:clean_addis_android/bloc/Signup/auth_state.dart';
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';

class SignupBloc extends Bloc<SignupEvent, UserState> {
  UserRepository repository;
  SignupBloc(this.repository) : super(UserState());

  void onSignup(
      String username, String email, String password,String phone,String address) {
    add(LoadUser(
        username: username,
        email: email,
        password: password,
        phone : phone,
        address : address
        ));
  }
  Stream<UserState> mapEventToState(SignupEvent event) async* {
      if (event is LoadUser) {
      try {
        yield UserLoadingState();

        await Future.delayed(Duration(seconds: 3));

        User user = User(
          username: event.username?.trim().toString(),
          email: event.email?.trim().toString(),
          password: event.password?.trim().toString(),
          phone: event.phone?.trim().toString(),
          address: event.address?.trim().toString()
        );
        final data = await repository.signup(user);
        print(data);
        yield UserLoadedState(user: data);
      } catch (e) {
        yield NetworkError(e.toString());
      }
    }
  }
}
