import 'package:clean_addis_android/bloc/Authentication/login_bloc.dart';
import 'package:clean_addis_android/bloc/Signup/auth_bloc.dart';
import 'package:clean_addis_android/bloc/Waste/user_waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/helpers/firebase_handler.dart';
import 'package:clean_addis_android/presentation/BottomNavigationBar.dart';
import 'package:clean_addis_android/presentation/Home.dart';
import 'package:clean_addis_android/presentation/Login.dart';
import 'package:clean_addis_android/presentation/UserProfile.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


import 'data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

late SharedPreferences sharedPreferences;




  
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  sharedPreferences = await SharedPreferences.getInstance();
  await dotenv.load(fileName: "assets/config/.env");
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.

   

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
            create: (BuildContext context) =>
                SignupBloc(UserRepository(dataProvider: UserDataProvider()))),
        BlocProvider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(
                  UserRepository(dataProvider: UserDataProvider()),
                )),
        BlocProvider<UserWasteBloc>(
          create: (context) => UserWasteBloc(WasteRepository(dataProvider: WasteDataProvider())),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes:{
          HomePage.id : (context) =>  HomePage(),
          Pages.id : (context) => Pages() ,
          UserProfilePage.id: (context) => UserProfilePage() 
        },
        home: LoginPage(),
      ),
    );

  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  dynamic data = message.data['data'];
  FirebaseNotifications.showNotification(data['title'], data['body']);
}
