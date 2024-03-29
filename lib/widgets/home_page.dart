import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meow_world_app/constants/mw_constants.dart';


class HomePage extends StatefulWidget{
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final List<String> imageList = [
    'assets/images/slide1.jpg',
    'assets/images/slide2.jpg',
    'assets/images/slide3.jpg',
  ];
  List<QueryDocumentSnapshot> data = [];
  QueryDocumentSnapshot? userData;
  final user = FirebaseAuth.instance.currentUser!;
  var docId;
  Future getDocId() async{
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
        docId = document.reference.id;
      }),
    );
  }
  Future getData() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: user.email).get();
    data.addAll(querySnapshot.docs);
    userData = querySnapshot.docs.first;
    setState(() {

    });
  }
  @override
  void initState(){
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 50, bottom:20, left: 20, right: 20),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.mainColor,
                        child: Padding(
                          padding: const EdgeInsets.all(2), // Border radius
                          child: ClipOval(child: Image.asset('assets/images/first-img.jpg')),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: Text('Hello,'),
                          ),
                          Container(
                            margin:  EdgeInsets.only(left: 12),
                            child: Text('${userData?['name']}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Badge(label: Text('2'), child: Icon(Icons.message_rounded, color: Colors.white,)),
                    ),
                    color: AppColors.mainColor,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 8),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  viewportFraction: 1,
                ),
                items: imageList.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey,
                        ),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                  child: Text('Category', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),),
                ),
                color: Color(0xFFF6C486)
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.mainColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Veterinay', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.mainColor),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  ),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.mainColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Grooming', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.mainColor),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  ),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.mainColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Pet Store', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.mainColor),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),),
                  Expanded(child: InkWell(
                    onTap: (){

                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColors.mainColor, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: 70,
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text('Tranning', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.mainColor),),
                              ],
                            )
                          ],
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 12, left: 8),
                    child: Text('Event', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                  color: Color(0xFFF6C486)
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                  color: AppColors.neutralColor10,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.neutralColor100.withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 0))
                  ]),
              child: Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12, left: 12),
                        child: Text('Find and Join in Special Events For Your Cats', style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, bottom: 12, top: 20),
                        width: 140,
                        height: 40,
                        child:  ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Color.fromRGBO(255, 104, 65, 1)),
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: Text('See More', style: TextStyle(color: Colors.white, fontSize: 16),),
                        ),
                      ),
                    ],
                  ), flex: 2,),
                  Expanded(child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.maxFinite,
                    margin: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0), // Bán kính của border radius
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Đồng bộ bán kính của ClipRRect với bán kính của Container
                      child: Image.asset(
                        'assets/images/slide3.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), flex: 1,)
                ],
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                  color: AppColors.neutralColor10,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.neutralColor100.withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0, 0))
                  ]),
              child: Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 12, left: 12),
                        child: Text('Find and Join in Special Events For Your Cats', style: TextStyle(fontSize: 18),),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 12, bottom: 12, top: 20),
                        width: 140,
                        height: 40,
                        child:  ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Color.fromRGBO(255, 104, 65, 1)),
                              ),
                            ),
                          ),
                          onPressed: (){},
                          child: Text('See More', style: TextStyle(color: Colors.white, fontSize: 16),),
                        ),
                      ),
                    ],
                  ), flex: 2,),
                  Expanded(child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.maxFinite,
                    margin: EdgeInsets.only(left: 12, top: 12, bottom: 12, right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0), // Bán kính của border radius
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0), // Đồng bộ bán kính của ClipRRect với bán kính của Container
                      child: Image.asset(
                        'assets/images/slide2.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ), flex: 1,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}