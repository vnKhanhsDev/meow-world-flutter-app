import 'package:meow_world_app/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_core/firebase_core.dart';

class SignInScreen extends StatefulWidget{
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  bool _isChecked = false;
  bool isFocused_e = false;
  bool isFocused_p = false;
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus = false;     // Prevents focus if tap on eye
    });
  }
  Future signIn() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );
  }
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFF6CFCD), // Màu nền của nút
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: Color.fromRGBO(255, 104, 65, 1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 40),
                  child: Text.rich(
                    TextSpan(
                      text: 'Đăng nhập', style: TextStyle(decoration: TextDecoration.none, color: Colors.black, fontSize: 34, fontWeight: FontWeight.bold), // default text style
                      children: <TextSpan>[
                        TextSpan(text: ' ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent[700])),
                      ],
                    ),
                  ),
                ),

                Container(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                              filled: true,
                              fillColor: Color(0xFFF6CFCD),
                              prefixIcon: Icon(Icons.email, color: isFocused_e ? Colors.black : Colors.grey,),
                              hintText: 'Email',
                              hintStyle: TextStyle(color: isFocused_e ? Colors.black : Colors.grey,),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none
                              ),

                            ),
                            onTap: () {
                              setState(() {
                                isFocused_e = true;
                              });
                            },
                            validator: (value) => EmailValidator.validate(value.toString()) ? null : "Hãy nhập email",
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 28),
                          child: TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: !_obscured,
                            focusNode: textFieldFocusNode,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                              hintText: 'Password',
                              hintStyle: TextStyle(color: isFocused_p ? Colors.black : Colors.grey,),
                              filled: true,
                              fillColor: Color(0xFFF6CFCD),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: Icon(Icons.lock_rounded,size: 24, color: isFocused_p ? Colors.black : Colors.grey,),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                                child: GestureDetector(
                                  onTap: _toggleObscured,
                                  child: Icon(
                                    _obscured
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded,
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                            validator: (val) => val.toString().length < 8 ? 'Mật khẩu phải chứa ít nhất 8 ký tự.' : null,
                            onTap: () {
                              setState(() {
                                isFocused_p = true;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked = value!;
                                  });
                                },
                                checkColor: Colors.white,
                                activeColor: Color.fromRGBO(255, 104, 65, 1),
                              ),
                              Text('Ghi nhớ tôi', style: TextStyle(color: _isChecked != false ? Colors.blueAccent : Colors.grey),)
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
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
                            onPressed: signIn,
                            child: Text('Đăng nhập', style: TextStyle(color: Colors.white, fontSize: 20),),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: TextButton(
                            onPressed: (){},
                            child: Text('Quên mật khẩu?', style: TextStyle(color: Color.fromRGBO(255, 104, 65, 1)),),
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
                                  child: Text('Hoặc', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, backgroundColor: Colors.white,), textAlign: TextAlign.center,),
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
                  child:SignInButton(
                    Buttons.Google,
                    text: "Tiếp tục với Google",
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  child:SignInButton(
                    Buttons.FacebookNew,
                    text: "Tiếp tục với Facebook",
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bạn chưa có tài khoản có tài khoản?', style: TextStyle(color: Colors.grey),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                  }, child: Text('Đăng ký', style: TextStyle(color: Color.fromRGBO(255, 104, 65, 1)),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}