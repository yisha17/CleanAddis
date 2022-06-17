
import 'dart:io';

import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/models/user.dart';


class UserRepository{
  UserDataProvider dataProvider;
  UserRepository({required this.dataProvider});

  Future<User> signup(User? user) {
  return this.dataProvider.signup(user!);
  }

  Future<User> login(User? user){
    return this.dataProvider.login(user!);
  }

  Future<User?> singleUser(String id, String token){
    return this.dataProvider.singleUser(id, token);
  }

  Future<User?> updateProfile(User user,String id, String token, File? file){
    return this.dataProvider.updateProfile(user, id, token, file);
  }


  Future<void> updatePassword(String password, String id, String token) {
   return this.dataProvider.updatePassword(password, id, token);
  }

  Future<void> createDeviceInfo(String token){
    return this.dataProvider.createDeviceInfo(token);
  }
}