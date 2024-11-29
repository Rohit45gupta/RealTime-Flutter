import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_db/view/intro_screen/home_screen.dart';
import 'package:realtime_db/view/intro_screen/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  void initState() {
    super.initState();
    var auth = FirebaseAuth.instance.currentUser?.uid;
    _timer = Timer(Duration(seconds: 3), () {
      if (auth != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignUpScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 80,
              child: Icon(Icons.person_pin,color: Colors.blueAccent,size: 50,),
            ),
            SizedBox(height: 20,),
            Text(
              'Splash Screen',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
