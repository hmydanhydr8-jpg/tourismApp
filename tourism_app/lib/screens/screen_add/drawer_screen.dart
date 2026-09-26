import 'package:flutter/material.dart';
import 'package:tourism_app/screens/screen_add/filters_screen.dart';

class DrawerScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 204, 174, 128),
              borderRadius: BorderRadius.only(),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 59, right: 10),
              child: Text(
                "اعدادات العرض",
                style: Theme.of(context).textTheme.headlineLarge
                    ?.copyWith(fontSize: 28),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BuildListTile(
                  title: "الرحلات",
                  icon: Icon(
                    Icons.explore,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/",
                        (route) => false,
                      );
                    });
                  },
                ),
                BuildListTile(
                  title: "الفلترة",
                  icon: Icon(
                    Icons.filter_list,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, FiltersScreen.filterRoute);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildListTile extends StatelessWidget {
  const BuildListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final Icon icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 22)),
      onTap: onTap,
    );
  }
}
