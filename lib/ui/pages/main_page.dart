import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_application/ui/pages/main_pages/community_page.dart';
import 'package:zero_waste_application/ui/pages/main_pages/diy_page.dart';
import 'package:zero_waste_application/ui/pages/main_pages/home_page.dart';
import 'package:zero_waste_application/ui/pages/profile_page.dart';
import 'package:zero_waste_application/ui/pages/userchat_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    required this.cam,
  });
  final CameraDescription cam;
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pagesIndex = 1;
  static List<Widget> _mainMenus = [];

  _onItemTapped(int index) {
    setState(() {
      _pagesIndex = index;
    });
  }

  bool changePage(indexTarget) {
    setState(() {
      _pagesIndex = indexTarget;
    });
    return true;
  }

  @override
  void initState() {
    super.initState();
    _mainMenus = [
      HomePage(changePage: changePage),
      const CommunityPage(),
      DiyPage(cam: widget.cam),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Hi, ${FirebaseAuth.instance.currentUser?.displayName}"),
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: CustomTheme.color.base1,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: BottomNavigationBar(
            currentIndex: _pagesIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                  "assets/images/icons/homepage.png",
                  color: _pagesIndex == 0 ? Colors.white : Colors.black,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  height: 40,
                  width: 50,
                  fit: BoxFit.fill,
                  "assets/images/icons/community logo.png",
                  color: _pagesIndex == 1 ? Colors.white : Colors.black,
                ),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  height: 40,
                  width: 40,
                  fit: BoxFit.fill,
                  "assets/images/icons/diy.png",
                  color: _pagesIndex == 2 ? Colors.white : Colors.black,
                ),
                label: 'DIY',
              ),
            ],
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: CustomTheme.color.gradientBackground1,
            ),
          ),
          child: Center(child: _mainMenus.elementAt(_pagesIndex))),
      floatingActionButton: _pagesIndex == 1
          ? FloatingActionButton.extended(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserChatPage()),
                );
              },
              icon: const Icon(Icons.message_rounded),
              label: const Text("Messages"),
            )
          : const Text(""),
    );
  }
}
