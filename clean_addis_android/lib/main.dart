import 'package:clean_addis_android/bloc/Authentication/login_bloc.dart';
import 'package:clean_addis_android/bloc/Signup/auth_bloc.dart';
import 'package:clean_addis_android/bloc/Waste/user_waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/presentation/AddWaste.dart';
import 'package:clean_addis_android/presentation/BottomNavigationBar.dart';
import 'package:clean_addis_android/presentation/Home.dart';
import 'package:clean_addis_android/presentation/Notification.dart';
import 'package:clean_addis_android/presentation/PublicPlace.dart';
import 'package:clean_addis_android/presentation/ReporList.dart';
import 'package:clean_addis_android/presentation/Report.dart';
import 'package:clean_addis_android/presentation/ReportDetail.dart';
import 'package:clean_addis_android/presentation/Seminar.dart';
import 'package:clean_addis_android/presentation/SeminarList.dart';
import 'package:clean_addis_android/presentation/Signup.dart';
import 'package:clean_addis_android/presentation/Login.dart';
import 'package:clean_addis_android/presentation/WasteBuy.dart';
import 'package:clean_addis_android/presentation/WasteBuyList.dart';
import 'package:clean_addis_android/presentation/WasteDonationList.dart';
import 'package:clean_addis_android/presentation/WasteSellList.dart';
import 'package:clean_addis_android/presentation/WasteDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'data/repositories/user_repository.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/confg/.env");
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

        home: LoginPage(),
      ),
    );

  }
}
