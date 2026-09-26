import 'package:flutter/material.dart';
import 'package:tourism_app/data_app.dart';
import 'package:tourism_app/screens/screen_add/drawer_screen.dart';
import 'package:tourism_app/screens/screen_app/screen_three.dart';

class ScreenTwo extends StatefulWidget {
  const ScreenTwo(this.availableTrips, {super.key});

  static const routeTwo = "two";

  final List<Trip> availableTrips;

  @override
  State<ScreenTwo> createState() => _ScreenTowState();
}

class _ScreenTowState extends State<ScreenTwo> {
  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    final categoryId = order["id"];
    final categoryTitle = order["title"];

    final filteredTrips = widget.availableTrips.where((trip) {
      return trip.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          categoryTitle!,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredTrips.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                ScreenThree.routeThree,
                arguments: {"id": filteredTrips[index].id},
              );
            },
            child: Boxes(
              imageUrl: filteredTrips[index].imageUrl,
              id: filteredTrips[index].id,
              title: filteredTrips[index].title,
              duration: filteredTrips[index].duration,
              tripType: filteredTrips[index].tripType,
              season: filteredTrips[index].season,
            ),
          );
        },
      ),
    );
  }
}

class Boxes extends StatelessWidget {
  const Boxes({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.title,
    required this.duration,
    required this.tripType,
    required this.season,
  });

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final TripType tripType;
  final Season season;

  String get tripTypeText {
    switch (tripType) {
      case TripType.exploration:
        return "استكشاف";
      case TripType.recovery:
        return "نقاهة";
      case TripType.activities:
        return "أنشطة";
      case TripType.therapy:
        return "معالجة";
    }
  }

  String get seasonText {
    switch (season) {
      case Season.winter:
        return "شتاء";
      case Season.spring:
        return "ربيع";
      case Season.summer:
        return "صيف";
      case Season.autumn:
        return "خريف";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 300,
        width: double.infinity,
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
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }

                            return child;
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(
                                "الانترنت غير متوفر",
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          },
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withValues(alpha: 0),
                                Colors.black.withValues(alpha: 0.8),
                              ],
                              stops: [0.6, 1],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 10,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.today, color: Colors.yellow),
                            SizedBox(width: 6),
                            Text("$duration أيام"),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.wb_sunny, color: Colors.yellow),
                            SizedBox(width: 6),
                            Text(seasonText),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.family_restroom,
                              color: Colors.yellow,
                            ),
                            SizedBox(width: 6),
                            Text(tripTypeText),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}