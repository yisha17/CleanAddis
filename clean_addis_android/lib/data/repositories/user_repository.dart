
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/models/user.dart';


class UserRepository{
  late UserDataProvider dataProvider;
  
  Future<User> signup(User user) {
    return this.dataProvider.signup(user);
  }
}