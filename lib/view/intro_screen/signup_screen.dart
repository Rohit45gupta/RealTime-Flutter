import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:realtime_db/controller/auth_service.dart';
import 'package:realtime_db/global_widget.dart';
import 'package:realtime_db/view/intro_screen/home_screen.dart';
import 'package:realtime_db/view/intro_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final auth = AuthService();
  TextEditingController nameController = TextEditingController();
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
              'Please SignUp',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            GlobalWidget.textEditForm(
                nameController, 'Enter Name', Icons.person),
            SizedBox(
              height: 10,
            ),
            GlobalWidget.textEditForm(
                emailController, 'Enter Email', Icons.email),
            SizedBox(
              height: 10,
            ),
            GlobalWidget.textEditForm(
                passwordController, 'Enter Password', Icons.password,
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
                signUp();
              },
              child: Text('signUp'),
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  },
                  child: Text(
                    'LogIn',
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

  void signUp() async {
    final user = await auth.createUserWithEmail(
        emailController.text, passwordController.text);
    if (user != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      Fluttertoast.showToast(msg: 'SignUp Successful');
    }
    log('SignUp failed ');
  }
}
