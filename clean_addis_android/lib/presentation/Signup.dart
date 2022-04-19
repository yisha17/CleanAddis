import 'package:clean_addis_android/bloc/auth_bloc.dart';
import 'package:clean_addis_android/bloc/auth_state.dart';
import 'package:clean_addis_android/presentation/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FocusNode myFocusNode = new FocusNode();
  var _formKey = GlobalKey<FormState>();
  final textControllerEmail = TextEditingController(),
      textControllerPassword = TextEditingController(),
      textControllerName = TextEditingController(),
      textControllerRepassword = TextEditingController();


      String _text = '';
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


  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = textControllerName.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }


  Widget buildUsername() =>
      BlocBuilder<SignupBloc, UserState>(
      buildWhen:(previous, current)=> previous.user!.username != current.user!.username,
      builder: (BuildContext context, state) {
        return TextField(
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
          controller: textControllerName,
          
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
              
              errorText: _errorText,
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder()),
        );
      });

  Widget buildEmail() => TextField(
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
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

  Widget buildPassword() => TextField(
        obscureText: true,
        textInputAction: TextInputAction.done,
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

  Widget confirmPassword() => TextField(
        obscureText: true,
        textInputAction: TextInputAction.done,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: SingleChildScrollView(
        child: Form(
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
                    onPressed: () => print('sdf'),
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
    );
  }
}
