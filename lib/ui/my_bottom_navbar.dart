import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_circle/ui/home/home_screen.dart';

class MyBottomNavbar extends StatefulWidget {
  @override
  _MyBottomNavbarState createState() => _MyBottomNavbarState();
}

class _MyBottomNavbarState extends State<MyBottomNavbar> {
  int currentIndex = 0;
  List<int> pages = [0,];

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      HomeScreen(),
      pages.contains(1)?HomeScreen():Container()
    ];
    return Scaffold(
      body: IndexedStack(
        children: _children,
        index: currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.house),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.gear),
            label: ''
          ),
        ],
        onTap: (val){
          setState(() {
            currentIndex = val;
            final _pages = pages;
            if (!_pages.contains(val)) {
              _pages.add(val);
            }
            setState(() {
              pages = _pages;
            });
          });
        },
      ),
    );
  }
}
