import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meow_world_app/constants/mw_constants.dart';
import 'package:meow_world_app/screens/auth/sign_up_screen.dart';
import 'package:meow_world_app/widgets/mw_button.dart';
import 'package:meow_world_app/widgets/mw_text_input_field.dart';
import 'package:meow_world_app/widgets/mw_password_input_field.dart';
import 'package:meow_world_app/utils/validate_username.dart';
import 'package:meow_world_app/screens/main_screen.dart';
import 'package:meow_world_app/screens/auth/forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

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
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50),
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
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  child: Image.asset(
                    'assets/images/sign_in_logo.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Username Field
                        MWTextInputField(
                          titleInputField: "Username hoặc Email",
                          controller: usernameController,
                          hintText: "Nhập username hoặc email",
                          validator: UsernameValidator.validate,
                        ),
                        SizedBox(height: 8),
                        //Password Field
                        MWPasswordInputField(controller: passwordController),
                        SizedBox(height: 10),
                        // Forgot Password
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
                                  'Ấn vào đây',
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
                        // Sign-in Button
                        MWButton(
                          pathIcon: null,
                          titleButton: "ĐĂNG NHẬP",
                          onPressed: signIn,
                        ),

                        // Seperate line
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(child: Divider(
                                color: AppColors.mainColor,
                                height: 1.0,
                              )),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  'Hoặc',
                                  style: TextStyle(
                                    color: AppColors.neutralColor60,
                                    fontSize: 14,
                                    fontWeight: AppFontWeights.regularOS
                                  ),
                                )
                              ),
                              Expanded(child: Divider(
                                color: AppColors.mainColor,
                                height: 1.0,
                              ))
                            ],
                          ),
                        ),

                        // Continue with Google
                        MWButton(
                          pathIcon: "assets/icons/google.svg",
                          titleButton: "Tiếp tục với Google",
                          onPressed: () {},
                        ),
                        SizedBox(height: 16),
                        // Continue with Facebook
                        MWButton(
                          pathIcon: "assets/icons/facebook.svg",
                          titleButton: "Tiếp tục với Facebook",
                          onPressed: () {},
                        ),
                        SizedBox(height: 30),

                        // Term and Policy Message
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30.0),
                          child: Center(
                            child: Text(
                              'Bằng cách tiếp tục, bạn đồng ý với Điều khoản và Chính sách của chúng tôi',
                              style: TextStyle(
                                color: AppColors.neutralColor100,
                                fontSize: 12,
                                fontWeight: AppFontWeights.regularOS
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),

      // Sign-up link
      bottomNavigationBar: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Bạn chưa có tài khoản?",
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
                  "Đăng ký",
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
                  MaterialPageRoute(builder: (_) => SignUpScreen()),
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
