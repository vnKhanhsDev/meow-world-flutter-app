import 'package:flutter/material.dart';
import 'package:meow_world_app/constants/mw_constants.dart';
import 'package:meow_world_app/screens/auth/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          child: Center(
            child: Text("Sign Up Page"),
          ),
        ),
      ),

      // Sign-in link
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bạn đã có tài khoản?",
              style: TextStyle(
                color: AppColors.neutralColor100,
                fontSize: 14,
                fontWeight: AppFontWeights.regularOS
              ),
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                child: Text(
                  "Đăng nhập",
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 14,
                    fontWeight: AppFontWeights.semiBoldOS
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => SignInScreen()),
                  (route) => false
                );
              },
            )
          ],
        ),
      ),
    );
  }
}