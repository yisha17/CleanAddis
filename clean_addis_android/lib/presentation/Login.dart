
import 'package:clean_addis_android/presentation/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9fff3),
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
                    onPressed: () => print('sdf'),
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
                        primary: Color(0xff68EA26))),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Don\'t Have an Account ?',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () => print('button'),
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
    );
  }

} 
