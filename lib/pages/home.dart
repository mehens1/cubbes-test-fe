import 'package:cubbes_test_fe/components/smallButton.dart';
import 'package:cubbes_test_fe/components/titleText.dart';
import 'package:cubbes_test_fe/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Cubbes-Black.png',
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(height: 100),
                const TitleText(text: "Dashboard"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: <Widget>[
                        _dashboardMenuItem("Courses", Icons.subject, () {}),
                        _dashboardMenuItem(
                            "My Courses", Icons.list_alt_rounded, () {}),
                        _dashboardMenuItem(
                            "Time-Table", Icons.group_work_rounded, () {}),
                        _dashboardMenuItem(
                            "My Profile", Icons.account_circle, () {}),
                      ],
                    ),
                  ),
                ),
                SmallButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    },
                    text: "Log Out")
              ],
            ),
          ),
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
