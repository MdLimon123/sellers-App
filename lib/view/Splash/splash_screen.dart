import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/view/mainScreen/home_screen.dart';

import '../authScreens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AuthScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('assets/images/sellers.webp'),
            ),
            const Text(
              'Seller app',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 26, letterSpacing: 1, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
