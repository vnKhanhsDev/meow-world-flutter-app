import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meow_world_app/screens/info_cat_screen.dart';

class InfoCatScreen extends StatefulWidget {
  Map<String, dynamic> infoCat;
  InfoCatScreen({required this.infoCat});
  @override
  State<InfoCatScreen> createState() => _InfoCatScreenState();
}

class _InfoCatScreenState extends State<InfoCatScreen> {
  String urlImage = '';

  Future<void> getCatImage() async {
    String id = widget.infoCat['id'];
    String urlSearch =
        'https://api.thecatapi.com/v1/images/search?breed_ids=$id';
    final response = await http.get(Uri.parse(urlSearch));
    if (response.statusCode == 200) {
      final List<dynamic> dataNew = jsonDecode(response.body);
      setState(() {
        urlImage = dataNew[0]['url'];
      });
    } else {
      throw Exception('Failed to load cat image');
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
                child: Center(child: Text('${widget.infoCat['name']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 8, bottom: 12),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(urlImage, fit: BoxFit.cover, width: double.maxFinite,),
            ),
          ),
          SliverToBoxAdapter(
            child: Text('${widget.infoCat['name']}'),
          ),
        ],
      )
    );
  }
}
