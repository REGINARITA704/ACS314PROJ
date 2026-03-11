import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../configs/colors.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: primaryColor,
        color: primaryColor,
        buttonBackgroundColor: secondaryColor,

        items: <Widget>[
          Icon(Icons.dashboard, size: 30, color: Colors.black),
          Icon(Icons.category, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
          Icon(Icons.list, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          //Handle button tap
        },
      ),
    );
  }
}
