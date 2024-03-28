import 'package:meow_world_app/screens/main_screen.dart';
import 'package:meow_world_app/screens/signin_screen.dart';
import 'package:meow_world_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class FisrtScreen extends StatefulWidget {
  const FisrtScreen({super.key});

  @override
  State<FisrtScreen> createState() => _FisrtScreenState();
}

class _FisrtScreenState extends State<FisrtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 150, left: 60, right: 60),
            width: double.infinity,
            child: Image.asset('assets/images/first-img.jpg', fit: BoxFit.cover,),
          )
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 120, // Chiều cao của Container chứa cột button
        padding: EdgeInsets.all(10), // Padding để tạo khoảng cách từ mép
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              height: 40,
              width: double.infinity,
              child:  ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color.fromRGBO(255, 104, 65, 1)), // Màu và độ dày của viền
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text('Tạo tài khoản', style: TextStyle(color: Color.fromRGBO(255, 104, 65, 1), fontSize: 18),),
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              child:  ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(255, 104, 65, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Color.fromRGBO(255, 104, 65, 1)),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
