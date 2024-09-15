import 'package:flutter/material.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/screens/article/article_screen.dart';
import 'package:quranhealer/screens/curhat/auth_curhat_screen.dart';
import 'package:quranhealer/screens/curhat/choose_ustadz_screen.dart';
import 'package:quranhealer/screens/dashboard/dahboard_screen.dart';
import 'package:quranhealer/screens/notloged/notloged_screen.dart';
import 'package:quranhealer/screens/profil/profil_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomBar extends StatefulWidget {
  final int dashboardIndex;
  final int currentIndex;
  const BottomBar({
    super.key,
    required this.dashboardIndex,
    required this.currentIndex,
  });

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();

    indexingPage();

    currentIndex = widget.currentIndex;
  }

  Future indexingPage() async {
    var token = await getToken();
    if (token.toString() == "null") {
      setState(() {
        _children = [
          DashboardScreen(
            dashboardIndex: widget.currentIndex,
          ),
          const NotLogedScreen(),
          const ArticleScreen(),
          const NotLogedScreen(),
        ];
      });
    } else {
      setState(() {
        _children = [
          DashboardScreen(
            dashboardIndex: widget.currentIndex,
          ),
          const AuthCurhatScreen(),
          const ArticleScreen(),
          const ProfilScreen(),
        ];
      });
    }
  }

  int currentIndex = 0;

  // ignore: unused_field
  List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<String> listAssets = [
    "assets/icons/bottombar/home.png",
    "assets/icons/bottombar/chat.png",
    "assets/icons/bottombar/user.png",
    "assets/icons/bottombar/homeselected.png",
    "assets/icons/bottombar/chatselected.png",
    "assets/icons/bottombar/userselected.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: null,
      // backgroundColor: Color(0xFF),
      body: IndexedStack(
        index: currentIndex,
        children: _children,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color(0xFF186D68).withOpacity(0.1),
        // color: Colors.white,
        height: 50,
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xFF186D68),
        index: currentIndex,
        // backgroundColor: const Color(0xFF186D68),
        items: [
          Icon(
            Icons.home,
            size: 25,
            color: currentIndex != 0 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 25,
            color: currentIndex != 1 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.article_outlined,
            size: 25,
            color: currentIndex != 2 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.person,
            size: 25,
            color: currentIndex != 3 ? Colors.black : Colors.white,
          ),
        ],
        onTap: (index) => onTabTapped(index),
      ),
    );
  }
}
