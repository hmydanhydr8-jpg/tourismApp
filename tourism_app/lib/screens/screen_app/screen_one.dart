import 'package:flutter/material.dart';
import 'package:tourism_app/data_app.dart';
import 'package:tourism_app/screens/screen_add/drawer_screen.dart';
import 'package:tourism_app/screens/screen_app/screen_tow.dart';

class ScreenOne extends StatefulWidget {
  const new({super.key});
  static const routeOne = "one";

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("قائمة الرحلات", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,
      ),
      drawer: DrawerScreen(),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 1 / 1.12,
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ScreenTwo.routeTwo,
                arguments: {
                  "id": categoriesData[index].id,
                  "title": categoriesData[index].title,
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  categoriesData[index].imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Text("الانترنت غير متوفر", style: TextStyle(fontSize: 20,)),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    return Stack(
                      fit: StackFit.passthrough,
                      children: [
                        child,

                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                          ),
                        ),

                        Center(
                          child: Text(
                            categoriesData[index].title,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
