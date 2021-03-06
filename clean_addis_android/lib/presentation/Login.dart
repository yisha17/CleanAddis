import 'package:clean_addis_android/bloc/Authentication/login_bloc.dart';
import 'package:clean_addis_android/bloc/Authentication/login_state.dart';
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:clean_addis_android/presentation/Home.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BottomNavigationBar.dart';
import 'Signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginBloc = LoginBloc(UserRepository(dataProvider: UserDataProvider()));
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSeen = false;
  final textControllerEmail = TextEditingController(),
      textControllerPassword = TextEditingController(),
      textControllerName = TextEditingController(),
      textControllerRepassword = TextEditingController();

  Widget buildUsername() => BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          controller: textControllerName,
          validator: (value) {
            if (value != null && value.length < 4) {
              return 'must be min 4 characters';
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.0),
              ),
              prefixIcon: Icon(
                Icons.account_box,
                color: Colors.black,
              ),
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder()),
        );
      });

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

  void messageDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
            actions: [
              ElevatedButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        });
  }

 

  Widget buildPassword() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: isSeen ? false : true,
            controller: textControllerPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            validator: (password) {
              if (password != null && password.length < 6) {
                return 'Password must be 6 charactesrs long';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  onPressed:(){
                    setState(() {
                      isSeen = !isSeen;
                    });
                    
                  },
                  icon:Icon(Icons.remove_red_eye)
                ),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder()),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: loginBloc,
      listener: (context, LoginState state) {
        if (state.user != null && state is AuthenticatedState) {
         
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pop();

          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => Pages()));

          Navigator.pushNamedAndRemoveUntil(
            context,
            Pages.id,
            (Route<dynamic> route) => false
          );
        } else if (state is UserLoadingState) {
          print("loading true");
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => loadingDialog(context));
        } else if (state is AuthenticationFailureState) {
          Navigator.of(context, rootNavigator: true).pop();
          print("printing");
          print(state.e);
          if (state.e == 'XMLHttpRequest error.') {
            String message = 'No Connection';
            ScaffoldMessenger.of(_scaffoldKey.currentContext!)
                .showSnackBar(SnackBar(content: Text(message)));
          }
          else if (state.e == 'Exception: Incorrect username or password') {
            String message = 'Username or Password not Correct';
            ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
              SnackBar(
                content: Text(message,style: TextStyle(color: Colors.white),),
                duration: Duration(seconds: 4),
                backgroundColor:Colors.red,
              ),
            );
          } 
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color(0xffe9fff3),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.14,
                  ),
                  cleanAddislogo(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  buildUsername(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final isValidForm = _formKey.currentState!.validate();
                      print(isValidForm);
                      if (isValidForm) {
                        loginBloc.onLogin(
                          textControllerName.text,
                          textControllerPassword.text,
                        );
                      }
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.white),
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      primary: Color(0xff68EA26),
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Don\'t Have an Account ?',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SignupPage()));
                        },
                        child: Text('Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                            )))
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
