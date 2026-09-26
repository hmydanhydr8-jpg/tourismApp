import 'package:flutter/material.dart';
import 'package:tourism_app/data_app.dart';
import 'package:tourism_app/screens/screen_app/screen_three.dart';
import 'package:tourism_app/screens/screen_app/screen_tow.dart';

class FavoriteScreen extends StatefulWidget {
  const new({super.key});
  static const favorite = "favorite";
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "المفضلة",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: listFavorite.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              await Navigator.pushNamed(
                context,
                ScreenThree.routeThree,
                arguments: {"id": listFavorite[index].id},
              );

              setState(() {});
            },
            child: Boxes(
              imageUrl: listFavorite[index].imageUrl,
              id: listFavorite[index].id,
              title: listFavorite[index].title,
              duration: listFavorite[index].duration,
              tripType: listFavorite[index].tripType,
              season: listFavorite[index].season,
            ),
          );
        },
      ),
    );
  }
}
