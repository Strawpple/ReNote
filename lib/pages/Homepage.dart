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
                child: Container(
                  child: Text('ReNote'),
                ),
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
        child: Padding(
          // Add Padding widget here
          padding: EdgeInsets.only(left: 40),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              child: Text(
                'Dashboard',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              child: SizedBox(height: 10),
            ),
            Container(
              child: Row(children: [
                Container(
                  child: Text('Total Income: '),
                ),
                Container(
                  child: SizedBox(width: 40),
                ),
                Container(
                  child: Text('Total Expense:'),
                ),
                Container(
                  child: SizedBox(width: 40),
                ),
                Container(
                  child: Text('# of source of income:'),
                ),
                Container(
                  child: SizedBox(width: 40),
                ),
              ]),
            ),
            Container(
              child: SizedBox(height: 10),
            ),
            Container(
              child: Row(children: [
                Container(
                  child: ElevatedButton(
                    child: Text('Add Income'),
                    onPressed: () {},
                  ),
                ),
                Container(
                  child: SizedBox(width: 10),
                ),
                Container(
                  child: ElevatedButton(
                    child: Text('Add Expense'),
                    onPressed: () {},
                  ),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
