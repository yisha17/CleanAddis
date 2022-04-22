import 'package:clean_addis_android/bloc/auth_bloc.dart';
import 'package:clean_addis_android/bloc/auth_state.dart';
import 'package:clean_addis_android/data/data_providers/user_data.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:clean_addis_android/presentation/Home.dart';
import 'package:clean_addis_android/presentation/utils.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FocusNode myFocusNode = new FocusNode();
  final signBloc = SignupBloc(UserRepository(dataProvider: UserDataProvider()));
  var _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController(),
      textControllerPassword = TextEditingController(),
      textControllerName = TextEditingController(),
      textControllerRepassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(myFocusNode);
    });
  }

  

  void loadingDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Loading..."),
            content: CircularProgressIndicator(
              strokeWidth: 6,
            ),
          );
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

  Widget buildUsername() => BlocBuilder<SignupBloc, UserState>(
      buildWhen: (previous, current) =>
          previous.user!.username != current.user!.username,
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

  Widget buildEmail() => BlocBuilder<SignupBloc, UserState>(
        buildWhen: (previous, current) =>
            previous.user!.email != current.user!.email,
        builder: (BuildContext context, state) {
          return TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            controller: textControllerEmail,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Not Valid Email'
                    : null,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
                prefixIcon: Icon(
                  Icons.mail,
                  color: Colors.black,
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder()),
          );
        },
      );

  Widget buildPassword() => BlocBuilder<SignupBloc, UserState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: true,
            controller: textControllerPassword,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            validator: (password) {
              if (password != null && password.length < 7) {
                return 'Password must be 7 charactesrs long';
              }
               else {
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
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder()),
          );
        },
      );

  Widget confirmPassword() => BlocBuilder<SignupBloc, UserState>(
        builder: (context, state) {
          return TextFormField(
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.done,
            controller: textControllerRepassword,
            validator: (repassword) {
              if (repassword != textControllerPassword.text) {
                return 'Password Does not match';
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
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder()),
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: signBloc,
      listener: (context, UserState state) {
        if (state.user != null && state is UserLoadedState) {
          Navigator.of(context, rootNavigator: true).pop();

          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        } else if (state is UserLoadingState) {
          //show loading
          WidgetsBinding.instance!
              .addPostFrameCallback((_) => loadingDialog(context));
        } else if (state is NetworkError) {
          Navigator.of(context, rootNavigator: true).pop();
          WidgetsBinding.instance!.addPostFrameCallback(
              (_) => messageDialog(context, "Upps... " + state.error));
        }
      },
      child: Scaffold(
        backgroundColor: lightgreen,
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
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  buildUsername(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  buildEmail(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  buildPassword(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  confirmPassword(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final isValidForm = _formKey.currentState!.validate();

                        if (isValidForm) {
                          signBloc.onSignup(
                            textControllerName.text,
                            textControllerEmail.text,
                            textControllerPassword.text,
                          );
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(
                          //         builder: (context) => HomePage()),
                          //     (route) => false);
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color: Colors.white),
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          primary: Color(0xff68EA26))),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Already Have an Account?',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () => print('button'),
                        child: Text('Login',
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
