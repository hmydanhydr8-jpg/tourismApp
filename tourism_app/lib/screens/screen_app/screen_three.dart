import 'package:flutter/material.dart';
import 'package:tourism_app/data_app.dart';

class ScreenThree extends StatefulWidget {
  const ScreenThree({super.key});
  static const routeThree = "three";

  @override
  State<ScreenThree> createState() => _ScreenThreeState();
}

class _ScreenThreeState extends State<ScreenThree> {
  @override
  Widget build(BuildContext context) {
    final order =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final screenId = order["id"];
    final filterFinal = tripsData.firstWhere((trip) {
      return trip.id == screenId;
    });
    var soul = listFavorite.contains(filterFinal);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(filterFinal.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.network(
                filterFinal.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }

                  return child;
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text("الانترنت غير متوفر", style: TextStyle(fontSize: 20)),
                  );
                },
              ),
            ),
            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0, left: 5),
                  child: Icon(Icons.directions_run, size: 26),
                ),
                BoxText(title: "الأنشطة"),
              ],
            ),
            BoxList(
              title: filterFinal.activities,
              itemCount: filterFinal.activities.length,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(Icons.event_note, size: 26),
                ),
                BoxText(title: "البرنامج اليومي"),
              ],
            ),
            BoxList(
              title: filterFinal.program,
              itemCount: filterFinal.program.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              margin: EdgeInsets.only(
                right: soul ? 110 : 70,
                left: soul ? 110 : 70,
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    soul ? "تمت الازالة" : "تمت الاضافة الى المفضلة",
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.teal,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          );

          setState(() {
            if (listFavorite.contains(filterFinal)) {
              listFavorite.remove(filterFinal);
            } else {
              listFavorite.add(filterFinal);
            }
          });
        },

        tooltip: "المفضلة",
        child: Icon(
          Icons.favorite,
          color: soul ? Colors.pinkAccent : Colors.grey,
        ),
      ),
    );
  }
}

//قوالب العمل
class BoxText extends StatelessWidget {
  const BoxText({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(color: Colors.black, fontSize: 28));
  }
}

class BoxList extends StatelessWidget {
  const BoxList({super.key, required this.title, required this.itemCount});
  final List<String> title;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.teal),
        ),
        height: 200,
        width: double.infinity,
        child: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (cmd, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(title[index]),
                ),
              ),
            );
          },
          physics: BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
