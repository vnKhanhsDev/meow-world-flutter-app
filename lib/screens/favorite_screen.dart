import 'package:flutter/material.dart';
import 'package:meow_world_app/screens/viewFavourites_screen.dart';
import 'package:meow_world_app/widgets/sub_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:meow_world_app/screens/info_cat_screen.dart';
import 'package:meow_world_app/constants/mw_constants.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  QueryDocumentSnapshot? userData;
  List<dynamic> listFavourites = [];
  List<String> listImage = [];
  bool isLoading = true;

  Future getFavourites() async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('favourites').where('email', isEqualTo: user.email).get();
    querySnapshot.docs.forEach((doc) {
      listFavourites.add(doc.data());
    });
    setState(() {

    });
    await getCatImage();
  }

  Future<void> getCatImage() async {
    for (int i = 0; i < listFavourites.length; i++) {
      String id = listFavourites[i]['id'];
      String urlSearch =
          'https://api.thecatapi.com/v1/images/search?breed_ids=$id';
      final response = await http.get(Uri.parse(urlSearch));
      if (response.statusCode == 200) {
        final List<dynamic> dataNew = jsonDecode(response.body);
        listImage.add(dataNew[0]['url']);
      } else {
        throw Exception('Failed to load cat image');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    getFavourites();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text('Favourites', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Expanded(

              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: isLoading
                    ? Center(child: CircularProgressIndicator(color: AppColors.mainColor,))
                    : ListView.builder(
                  itemCount: listFavourites.length,
                  itemBuilder: (context, index) {
                    return Container(
                        width: double.infinity,
                        height: 120,
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (context) => ViewFavoritesScreen(infoCat: listFavourites[index])));
                          },
                          child: Card(
                            margin: EdgeInsets.only(bottom: 12),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child:
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(listImage[index]),
                                          fit: BoxFit.cover,
                                        )
                                    ),
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child:Container(
                                      margin: EdgeInsets.only(left: 12, top: 12, right: 12),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(listFavourites[index]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(50),
                                                  color: AppColors.mainColor,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.favorite_border, size: 20,),
                                                  onPressed: () {

                                                  },
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star, color: Colors.yellow, size: 14,),
                                              Text('4.5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),)
                                            ],
                                          ),
                                          Container(
                                            child: Text('Nguồn gốc: ${listFavourites[index]['origin']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
                                          )
                                        ],
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                        )
                    );
                  },
                ),
              )
          ),
        ],
      ),
    );
  }
}
