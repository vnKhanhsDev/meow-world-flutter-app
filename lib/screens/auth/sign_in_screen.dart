import 'package:meow_world_app/constants/mw_constants.dart';
import 'package:meow_world_app/screens/auth/forgot_password_screen.dart';
import 'package:meow_world_app/screens/main_screen.dart';
import 'package:meow_world_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:meow_world_app/utils/validate_username.dart';
import 'package:meow_world_app/widgets/mw_button.dart';
import 'package:meow_world_app/widgets/mw_password_input_field.dart';
import 'package:meow_world_app/widgets/mw_text_input_field.dart';

class SignInScreen extends StatefulWidget {
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isChecked = false;
  bool isFocused_e = false;
  bool isFocused_p = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  // Future signIn() async {
  //   await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim());
  // }

  void signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController.text.trim(),
          password: passwordController.text.trim()
      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => MainScreen()),
          (route) => false
      );
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Đăng nhập',
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 32,
                    fontWeight: AppFontWeights.boldOS
                  ),
                ),
                SizedBox(height: 16),
                Image.asset(
                  'assets/images/sign_in_logo.png',
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MWTextInputField(
                          titleInputField: "Username hoặc Email",
                          controller: usernameController,
                          hintText: "Nhập username hoặc email",
                          validator: UsernameValidator.validate,
                        ),
                        SizedBox(height: 8),
                        MWPasswordInputField(controller: passwordController),
                        SizedBox(height: 8),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Quên mật khẩu? ',
                                style: TextStyle(
                                  color: AppColors.neutralColor100,
                                  fontSize: 12,
                                  fontWeight: AppFontWeights.regularOS
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  'Click here',
                                  style: TextStyle(
                                    color: AppColors.neutralColor100,
                                    fontSize: 12,
                                    fontWeight: AppFontWeights.mediumOS
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => ForgotPasswordScreen()),
                                      (route) => false
                                  );
                                }
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        MWButton(nameButton: "đăng nhập", onPressed: signIn),

                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Quên mật khẩu?',
                          style:
                              TextStyle(color: Color.fromRGBO(255, 104, 65, 1)),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 10.0),
                              height: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                'Hoặc',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                  backgroundColor: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              height: 40,
              child: SignInButton(
                Buttons.Google,
                text: "Tiếp tục với Google",
                onPressed: () {},
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              child: SignInButton(
                Buttons.FacebookNew,
                text: "Tiếp tục với Facebook",
                onPressed: () {},
              ),
            ),
          ],
        ),
      )),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         margin: EdgeInsets.only(bottom: 12),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               'Bạn chưa có tài khoản có tài khoản?',
      //               style: TextStyle(color: Colors.grey),
      //             ),
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => SignUpScreen()));
      //                 },
      //                 child: Text(
      //                   'Đăng ký',
      //                   style:
      //                       TextStyle(color: Color.fromRGBO(255, 104, 65, 1)),
      //                 ))
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
