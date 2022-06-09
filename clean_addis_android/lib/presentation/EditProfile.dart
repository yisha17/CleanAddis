import 'dart:io';

import 'package:clean_addis_android/bloc/Authentication/login_event.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:clean_addis_android/presentation/Setting.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/Authentication/login_bloc.dart';
import '../bloc/Authentication/login_state.dart';
import '../data/data_providers/user_data.dart';
import 'Home.dart';

class EditProfilePage extends StatefulWidget {
  final int? id;
  final String? password;
  final String? profile;
  final String? username;
  final String? email;
  final String? address;
  final String? role;
  final String? phone;

  const EditProfilePage(
      {Key? key,
      this.id,
      this.profile,
      this.password,
      this.username,
      this.email,
      this.address,
      this.role,
      this.phone})
      : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  final userBloc = LoginBloc(UserRepository(dataProvider: UserDataProvider()));
  bool isCurrentPassword = true;
  File? image;
  final ImagePicker _picker = ImagePicker();
  late String password;

  @override
  void initState() {
    super.initState();
  }
  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Center(child: Text('Updating..')),
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
  late var username_controller = TextEditingController(text: widget.username),
      password_controller = TextEditingController(text: widget.password),
      email_controller = TextEditingController(text: widget.email),
      phone_controller = TextEditingController(text: widget.phone),
      address_controller = TextEditingController(text: widget.address);
  var _formKey = GlobalKey<FormState>();

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
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
    return BlocListener(
      bloc: userBloc,
      listener: (context, LoginState state) {
        if (state is UserDetailState) {
          WidgetsBinding.instance!.addPostFrameCallback(
            (_) => messageDialog(
              context: context,
              icon: Icons.account_circle,
              color: Colors.green,
              title: 'Profile Updated',
              body: 'Your Profile has been Successfully Updated',
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      )),
                )
              ],
            ),
          );
        }
        if (state is UserLoadingState){
            WidgetsBinding.instance!
              .addPostFrameCallback((_) => loadingDialog(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreen,
          elevation: 0,
          title: Text(
            "Edit Profile",
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: logogreen,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: logogreen,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage()));
              },
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
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
                              image: this.image != null
                                  ? FileImage(image!) as ImageProvider
                                  : NetworkImage(
                                      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: logogreen,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () {
                                  _pickImage();
                                },
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  buildTextField("Full Name", "Dor Alex", false,
                      controller: username_controller),
                  buildTextField("E-mail", "alexd@gmail.com", false,
                      controller: email_controller),
                  buildTextField("Password", "********", true,
                      controller: password_controller),
                  buildTextField("Address", "AA, Ethiopia", false,
                      controller: address_controller),
                  buildTextField("Phone", "0942343243", false,
                      controller: phone_controller),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('lsave pressed');
                          userBloc
                            ..add(UserUpdateEvent(
                                id: widget.id!,
                                username: username_controller.text,
                                email: email_controller.text,
                                phone: phone_controller.text,
                                address: address_controller.text,
                                profile: this.image));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: logogreen,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField,
      {required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
