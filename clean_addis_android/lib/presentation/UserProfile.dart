

import 'package:clean_addis_android/bloc/Authentication/login_bloc.dart';
import 'package:clean_addis_android/bloc/Authentication/login_event.dart';
import 'package:clean_addis_android/bloc/Authentication/login_state.dart';
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:clean_addis_android/presentation/EditProfile.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final userBloc = LoginBloc(UserRepository(dataProvider: UserDataProvider()));
  int? id;
  final _storage = FlutterSecureStorage();
  String? password;
  String? profile;
  String? username;
  String? email;
  String? address;
  String? role;
  String? phone;
  @override
  void initState() {
    super.initState();
    userBloc..add(UserProfileEvent());
  }

  Widget verticalSpace(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  Widget buildText(
      {required IconData? icon,
      bool isFullWidth = true,
      String? label,
      required String text,
      required Color color}) {
    return Container(
      width: isFullWidth
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 21,
                color: color,
              ),
              horizontalSpace(0.01),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          verticalSpace(0.01),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }

  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(child: Text('checking..')),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ));
        });
  }

  Widget _profileImage({String? image}) {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
            border: Border.all(
                width: 4, color: Theme.of(context).scaffoldBackgroundColor),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 10))
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  image != ''
                      ? image!
                      : "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                ))),
      ),
    );
  }

  void messageDialog({
    required BuildContext context,
    IconData? icon,
    required Color color,
    required String title,
    required String body,
    required List<Widget> actions,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Container(
                color: color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      icon,
                      size: 55,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              content: Container(
                height: 80,
                child: Column(children: [
                  Text(
                    body,
                    style: TextStyle(fontSize: 20),
                  )
                ]),
              ),
              contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              actions: actions);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: logogreen,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              messageDialog(
              context: context,
              icon:Icons.edit,
               color: logogreen,
                title: 'Edit Profile',
                 body:'Are you sure You wasnt to edit your profile',
                actions: [
                  Center(
                    child: Row(
                      children: [
                        TextButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                              EditProfilePage(
                                id: this.id,
                                username: this.username,
                                password: this.password,
                                email: this.email,
                                profile:this.profile,
                                address: this.address,
                                phone:this.phone
                              )));
                            
                            }),
                            TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true).pop();
                            }),
                      ],
                    )
                  )
                ]);
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder(
          bloc: userBloc,
          builder: (context, state) {
            if (state is UserLoadingState) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            if (state is UserDetailState) {
              final user = state.user;
              Future.delayed(Duration.zero, () async {
                this.password = await _storage.read(key: 'password');
                setState(() {
                this.id = user.id;
                this.username = user.username;
                this.email = user.email;
                this.profile = user.profile;
                this.address = user.address;
                this.phone = user.phone;
              });
              });

              
              
              return Column(
                children: [
                  verticalSpace(0.02),
                  _profileImage(image: user.profile!),
                  verticalSpace(0.02),
                  
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              user.report_count.toString(),
                              style: TextStyle(color: Colors.red, fontSize: 35),
                            ),
                            Text(
                              'Reports',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            Text(
                              user.donate_count.toString(),
                              style: TextStyle(color: Colors.red, fontSize: 35),
                            ),
                            Text(
                              'Donations',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                        Column(
                          children: [
                            Text(
                              user.sell_count.toString(),
                              style:
                                  TextStyle(color: Colors.yellow, fontSize: 35),
                            ),
                            Text(
                              'sold',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  verticalSpace(0.02),
                  buildText(
                      icon: Icons.account_circle,
                      label: 'Username',
                      text: user.username!,
                      color: Colors.black),
                  Divider(),
                  verticalSpace(0.02),
                  buildText(
                      icon: Icons.email,
                      label: 'Email',
                      text: user.email!,
                      color: Colors.black),
                  Divider(),
                  verticalSpace(0.02),
                  buildText(
                      icon: Icons.work,
                      label: 'Role',
                      text: user.role!,
                      color: Colors.black),
                  Divider(),
                  verticalSpace(0.02),
                  buildText(
                      icon: Icons.my_location,
                      label: 'Address',
                      text:
                          user.address != null ? user.address! : 'no address ',
                      color: Colors.black),
                  Divider(),
                  verticalSpace(0.02),
                  buildText(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      text:
                          user.phone != '' ? user.phone! : 'no phone number',
                      color: Colors.black),
                  Divider(),
                ],
                
              );
              
            }
            if (state is AuthenticationFailureState) {
              return Center(
                child: Text(
                    'Error happened.please check your internet connection!'),
              );
            }
            return Center();
          }),
    );
  }
}
