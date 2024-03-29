import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget{
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting>{

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings, size: 30,),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: Text('Cài đặt', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              width: double.infinity,
              child: InkWell(
                onTap: (){

                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thông tin cá nhân'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: double.infinity,
              child: InkWell(
                onTap: (){

                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Bảo mật'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: double.infinity,
              child: InkWell(
                onTap: (){

                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Trợ giúp & Hỗ trợ'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: double.infinity,
              child: InkWell(
                onTap: (){

                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Ngôn ngữ'),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8),
              width: double.infinity,
              child: InkWell(
                onTap: (){
                  FirebaseAuth.instance.signOut();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Đăng xuất'),
                        Icon(Icons.logout),
                      ],
                    ),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}