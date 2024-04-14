import 'package:cubbes_test_fe/components/pageLogo.dart';
import 'package:cubbes_test_fe/components/smallButton.dart';
import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/pages/login.dart';
import 'package:cubbes_test_fe/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const HeaderLogo(),
            const TitleText(text: "Dashboard"),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  _dashboardMenuItem(
                      "My Courses", Icons.list_alt_rounded, () {}),
                  _dashboardMenuItem("Add Course", Icons.subject, () {}),
                  _dashboardMenuItem(
                      "Time-Table", Icons.group_work_rounded, () {}),
                  _dashboardMenuItem("My Profile", Icons.account_circle, () {}),
                ],
              ),
            ),
            SmallButton(
              onPressed: () {
                logout(context);
              },
              text: "Log Out",
            )
          ],
        ),
      ),
    );
  }

  Widget _dashboardMenuItem(
      String title, IconData iconData, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black,
        elevation: 3,
        margin: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 32,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
