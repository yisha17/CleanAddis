
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/models/user.dart';


class UserRepository{
  UserDataProvider dataProvider;
  UserRepository({required this.dataProvider});

  Future<User> signup(User? user) {
  print(user);
  print(user!.username);
  print(user.email);
  print(user.password);
  return this.dataProvider.signup(user);
  }
}