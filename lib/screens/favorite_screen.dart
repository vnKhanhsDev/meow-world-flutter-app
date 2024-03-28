import 'package:flutter/material.dart';
import 'package:meow_world_app/widgets/sub_app_bar.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar("Các loài mèo đã thích"),
      body: Container(
        child: Center(
          child: Text("Cat Card List"),
        ),
      )
    );
  }
}