import 'package:flutter/material.dart';
import 'package:tourism_app/screens/screen_add/drawer_screen.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.onSave,
    required this.currentFilters,
  });
static const filterRoute = "lolol";
  final void Function(Map<String, bool>) onSave;
  final Map<String, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var isInSummer = false;
  var isInWinter = false;
  var isForFamily = false;

  @override
  void initState() {
    super.initState();

    isInSummer = widget.currentFilters["summer"] ?? false;
    isInWinter = widget.currentFilters["winter"] ?? false;
    isForFamily = widget.currentFilters["family"] ?? false;
  }

  Widget buildSwitchListTile(
    String title,
    String subtitle,
    bool currentValue,
    void Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "الفلترة",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
            onPressed: () {
              widget.onSave({
                "summer": isInSummer,
                "winter": isInWinter,
                "family": isForFamily,
              });

              Navigator.pop(context);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                    "الرحلات الصيفية فقط",
                    "اظهار الرحلات في فصل الصيف فقط",
                    isInSummer,
                    (newValue) {
                      setState(() {
                        isInSummer = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    "الرحلات الشتوية فقط",
                    "اظهار الرحلات في فصل الشتاء فقط",
                    isInWinter,
                    (newValue) {
                      setState(() {
                        isInWinter = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    "للعائلات",
                    "اظهار الرحلات التي للعائلات فقط",
                    isForFamily,
                    (newValue) {
                      setState(() {
                        isForFamily = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
