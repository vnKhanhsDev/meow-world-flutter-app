import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  TextEditingController searchController = TextEditingController();
  List<dynamic> listCat = [];
  List<String> listImage = [];
  final String apiKey = 'live_oBzpxjUvNPUKzsoY7XpDQj6ecLcr4KnjDd56a3MuJSynIZxggqBiO95XksFEpoap';
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getListCat();
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
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(255, 104, 65, 1),
                            width: 0.1,
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
          Expanded(child: isLoading // Hiển thị CircularProgressIndicator() nếu đang tải
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(listImage[index]),
                ),
                title: Text(listCat[index]['name']),
              );
            },
          ),

          ),
        ],
      ),
    );
  }
}

