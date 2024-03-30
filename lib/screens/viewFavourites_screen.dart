import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meow_world_app/constants/mw_constants.dart';
import 'package:meow_world_app/screens/info_cat_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
class ViewFavoritesScreen extends StatefulWidget {
  Map<String, dynamic> infoCat;
  ViewFavoritesScreen({required this.infoCat});
  @override
  State<ViewFavoritesScreen> createState() => _ViewFavoritesScreenState();
}

class _ViewFavoritesScreenState extends State<ViewFavoritesScreen> {
  @override
  final user = FirebaseAuth.instance.currentUser!;
  QueryDocumentSnapshot? userData;

  String urlImage = '';
  bool isLoading = true;


  Future addFavourite() async{
    await FirebaseFirestore.instance.collection('favourites').add({
      'email': user.email,
      ...widget.infoCat,
    });
  }

  Future<void> getCatImage() async {
    setState(() {
      isLoading = true;
    });
    String id = widget.infoCat['id'];
    String urlSearch =
        'https://api.thecatapi.com/v1/images/search?breed_ids=$id';
    final response = await http.get(Uri.parse(urlSearch));
    if (response.statusCode == 200) {
      final List<dynamic> dataNew = jsonDecode(response.body);
      setState(() {
        urlImage = dataNew[0]['url'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load cat image');
    }
  }
  Future<void> _launchInWebView() async {
    String url = widget.infoCat['wikipedia_url'];
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  void initState(){
    super.initState();
    getCatImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${widget.infoCat['name']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal)),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.mainColor,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.favorite_border, size: 24,),
                              onPressed: () {

                              },
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.blueGrey, size: 20,),
                          Text('${widget.infoCat['origin']}', style: TextStyle(fontSize: 16, color: Colors.blueGrey),)
                        ],
                      )
                    ],
                  ),
                ),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 8, bottom: 8),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 400,
            flexibleSpace:isLoading
                ? Center(child: CircularProgressIndicator( color: AppColors.mainColor,))
                :FlexibleSpaceBar(
              background: Image.network(urlImage, fit: BoxFit.cover, width: double.maxFinite,),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child:Text.rich(
                      TextSpan(
                        text: 'Life span: ', style: TextStyle(decoration: TextDecoration.none, color: AppColors.mainColor, fontSize: 18,), // default text style
                        children: <TextSpan>[
                          TextSpan(text: ' ${widget.infoCat['life_span']} years', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        text: 'Temperament: ', style: TextStyle(decoration: TextDecoration.none, color: AppColors.mainColor, fontSize: 18,), // default text style
                        children: <TextSpan>[
                          TextSpan(text: ' ${widget.infoCat['temperament']}', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black)),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    width: double.infinity,
                    child: Text.rich(
                      TextSpan(
                        text: 'Description: ', style: TextStyle(decoration: TextDecoration.none, color: AppColors.mainColor, fontSize: 18,), // default text style
                        children: <TextSpan>[
                          TextSpan(text: ' ${widget.infoCat['description']}', style: TextStyle(fontWeight: FontWeight.w300, color: Colors.black)),
                        ],
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              flex: 1,
              child:Container(
                margin: EdgeInsets.only(bottom: 12),
                height: 40,
                width: double.infinity,
                child:  ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: AppColors.mainColor), // Màu và độ dày của viền
                      ),
                    ),
                  ),
                  onPressed: _launchInWebView,
                  child: Text('Doc', style: TextStyle(color: AppColors.mainColor, fontSize: 18),),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getCatImage,
        tooltip: 'Reload',
        child: Icon(Icons.image, color: Colors.white,),
        backgroundColor: AppColors.mainColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
