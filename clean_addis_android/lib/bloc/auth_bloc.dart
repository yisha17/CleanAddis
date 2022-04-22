import 'package:bloc/bloc.dart';
import 'package:clean_addis_android/bloc/auth_event.dart';
import 'package:clean_addis_android/bloc/auth_state.dart';
import 'package:clean_addis_android/data/models/user.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';

class SignupBloc extends Bloc<SignupEvent, UserState> {
  UserRepository repository;
  SignupBloc(this.repository) : super(UserState(status: UserStatus.unauthenticated));

  void onSignup(
      String username, String email, String password) {
    add(LoadUser(
        username: username,
        email: email,
        password: password,
        ));
  }
  Stream<UserState> mapEventToState(SignupEvent event) async* {
    if (event is UsernameChanged) {
      if (event.username == '') {
        yield FieldEmptyError();
      }
    } else if (event is EmailChanged) {
      yield IncorrectEmailFormat();
    } else if (event is PasswordChanged) {
      if (event.password.length > 6) {
        yield ShortPasswordError();
      }
      if (event.password == '') {
        yield FieldEmptyError();
      }
    } else if (event is LoadUser) {
      try {
        yield UserLoadingState();

        await Future.delayed(Duration(seconds: 3));

        User user = User(
          username: event.username?.trim().toString(),
          email: event.email?.trim().toString(),
          password: event.password?.trim().toString(),
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
