import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meow_world_app/constants/mw_constants.dart';
import 'package:meow_world_app/screens/main_screen.dart';
import 'package:meow_world_app/screens/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => SignInScreen()),
            (route) => false
        );
      } else {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => MainScreen()), (route) => false
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 130,
              height: 130,
            ),
            SizedBox(height: 20),
            Text(
              'MeowWorld',
              style: TextStyle(
                  color: AppColors.neutralColor10,
                  fontSize: 32,
                  fontWeight: AppFontWeights.semiBoldOS),
            ),
            Text(
              'Khám phá thế giới loài mèo',
              style: TextStyle(
                  color: AppColors.neutralColor10,
                  fontSize: 16,
                  fontWeight: AppFontWeights.mediumOS),
            )
          ],
        ),
      ),
    );
  }
}
