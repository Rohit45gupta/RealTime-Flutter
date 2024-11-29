import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realtime_db/controller/auth_service.dart';
import 'package:realtime_db/global_widget.dart';
import 'package:realtime_db/view/intro_screen/home_screen.dart';
import 'package:realtime_db/view/intro_screen/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.person_pin,
              size: 120,
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Please LogIn',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            GlobalWidget.textEditForm(emailController, 'Enter Email', Icons.email),
            SizedBox(
              height: 10,
            ),
           GlobalWidget.textEditForm(passwordController, 'Enter Password', Icons.password,
                obscure: true),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  shadowColor: Colors.blueGrey,
                  elevation: 7,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.white, width: 2)),
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15)),
              onPressed: () {
                logIn();
              },
              child: Text('logIn'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have account?',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'SignUp',
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.orangeAccent,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


  void logIn() async {
    final user = await auth.signInUserWithEmail(
        emailController.text, passwordController.text);
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      Fluttertoast.showToast(msg: 'LogIn SuccessFul');
    }
    log('LogIn failed');
  }
}
