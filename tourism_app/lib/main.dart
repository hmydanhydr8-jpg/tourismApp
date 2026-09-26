import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tourism_app/data_app.dart';
import 'package:tourism_app/screens/screen_add/filters_screen.dart';
import 'package:tourism_app/screens/screen_app/favorite_screen.dart';
import 'package:tourism_app/screens/screen_app/screen_one.dart';
import 'package:tourism_app/screens/screen_add/tabs_screen.dart';
import 'package:tourism_app/screens/screen_app/screen_three.dart';
import 'package:tourism_app/screens/screen_app/screen_tow.dart';

void main() {
  runApp(const MyApp());
}

var isInSummer = false;
var isInWinter = false;
var isForFamily = false;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    "summer": false,
    "winter": false,
    "family": false,
  };

  List<Trip> availableTrips = tripsData;

  void saveFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      availableTrips = tripsData.where((trip) {
        if (filters["summer"] == true && trip.isInSummer == false) {
          return false;
        }

        if (filters["winter"] == true && trip.isInWinter == false) {
          return false;
        }

        if (filters["family"] == true && trip.isForFamilies == false) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tourism",
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale("ar"), Locale("en")],
      locale: Locale("ar"),
      theme: ThemeData(
        primaryColor: Colors.teal,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        fontFamily: "ElMessiri",
        textTheme: ThemeData.light().textTheme.copyWith(
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "ElMessiri",
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: "ElMessiri",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => TabScreens(),
        FavoriteScreen.favorite: (context) => FavoriteScreen(),
        ScreenOne.routeOne: (context) => ScreenOne(),
        ScreenTwo.routeTwo: (context) => ScreenTwo(availableTrips),
        ScreenThree.routeThree: (context) => ScreenThree(),
        FiltersScreen.filterRoute: (context) => FiltersScreen(
  onSave: saveFilters,
  currentFilters: filters,
),
      },
    );
  }
}