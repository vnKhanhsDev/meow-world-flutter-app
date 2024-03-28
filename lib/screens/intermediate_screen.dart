import 'package:meow_world_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meow_world_app/screens/signin_screen.dart';

class IntermediateScreen extends StatefulWidget{
  State<IntermediateScreen> createState() => _IntermediateScreenState();
}

class _IntermediateScreenState extends State<IntermediateScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return MainScreen();
          }else{
            return SignInScreen();
          }
        },
      ),
    );
  }
}