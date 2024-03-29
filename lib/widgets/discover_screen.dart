import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meow_world_app/screens/info_cat_screen.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> allBreed = [];
  List<String> allImage = [];
  List<dynamic> listCat = [];
  List<String> listImage = [];
  final String apiKey = 'live_oBzpxjUvNPUKzsoY7XpDQj6ecLcr4KnjDd56a3MuJSynIZxggqBiO95XksFEpoap';
  bool isLoading = true;

  List<dynamic> foundCat = [];
  List<String> foundCatImage =[];
  @override
  void initState() {
    super.initState();
    getListCat();
  }
  Future<void> _runFilter(String enteredKeyword) async{
    List<dynamic> results = [];
    List<String> results_2 = [];
    if (enteredKeyword.isEmpty) {

      results = listCat;
      results_2 = listImage;
    } else {
      results = listCat
          .where((cat) =>
          cat["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      for(int i = 0; i < results.length; i++){
        String id = results[i]['id'];
        String urlSearch =
            'https://api.thecatapi.com/v1/images/search?breed_ids=$id';
        final response = await http.get(Uri.parse(urlSearch));
        if (response.statusCode == 200) {
          final List<dynamic> dataNew = jsonDecode(response.body);
          results_2.add(dataNew[0]['url']);
        } else {
          throw Exception('Failed to load cat image');
        }
      }
    }
    setState(() {
      foundCat = results;
      foundCatImage = results_2;
      isLoading = false;
    });

  }
  Future<void> getListCat() async {
    final response = await http.get(
      Uri.parse('https://api.thecatapi.com/v1/breeds?limit=20'),
      headers: {'x-api-key': apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        listCat = data;
        foundCat = listCat;
      });
      await getCatImage();
    } else {
      throw Exception('Failed to load cat breeds');
    }
  }

  Future<void> getCatImage() async {
    for (int i = 0; i < listCat.length; i++) {
      String id = listCat[i]['id'];
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
        foundCatImage = listImage;
        isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text('Khám phá', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child:
                Container(
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(255, 104, 65, 1),
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0)
                    ),
                  ),
                ),
              ),
              Expanded(child:
                Container(
                  margin: EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Color.fromRGBO(255, 104, 65, 1),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {

                    },
                    color: Colors.white,
                  ),
                ),
              )

            ],
          ),
          Expanded(

            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: foundCat.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    height: 120,
                    child: InkWell(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(fullscreenDialog: true, builder: (context) => InfoCatScreen(infoCat: foundCat[index])));
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
                                      image: NetworkImage(foundCatImage[index]),
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
                                          Text(foundCat[index]['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: Colors.black,
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
                                        child: Text('Nguồn gốc: ${foundCat[index]['origin']}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),),
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

