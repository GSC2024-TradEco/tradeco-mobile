import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zero_waste_application/ui/pages/main_pages/community_page.dart';
import 'package:zero_waste_application/ui/pages/main_pages/diy_page.dart';
import 'package:zero_waste_application/ui/pages/main_pages/home_page.dart';
import 'package:zero_waste_application/ui/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pagesIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _pagesIndex = index;
    });
  }

  static const List<Widget> _mainMenus = <Widget>[
    HomePage(),
    CommunityPage(),
    DiyPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hi Aldi"),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: const Icon(Icons.person),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pagesIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'DIY'),
        ],
      ),
      body: Center(child: _mainMenus.elementAt(_pagesIndex)),
      floatingActionButton: _pagesIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text("POST"),
            )
          : const Text(""),
    );
  }
}
