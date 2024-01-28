import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:renote/pages/Profile.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AdaptiveNavBar(
        automaticallyImplyLeading: false,
        screenWidth: sw,
        title: RichText(
          text: TextSpan(
            children: [
              WidgetSpan(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                // child: Container(
                //     height: 70, child: Image.asset('lib/assets/images/J.png')),
              )),
            ],
          ),
        ),
        navBarItems: [
          NavBarItem(
            text: "Profile",
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => profile()));
            },
          ),
          NavBarItem(
            text: "Log out",
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: Container(
        child: Text("Homepage"),
      ),
    );
  }
}
