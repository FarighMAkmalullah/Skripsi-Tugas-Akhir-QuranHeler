import 'package:flutter/material.dart';
import 'package:quranhealer/screens/dashboard/dahboard_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  int currentIndex = 0;

  final List<Widget> _children = [
    const DashboardScreen(),
    const Center(
      child: Text("Curhat Uztad Coming Soon"),
    ),
    const Center(
      child: Text("Profil Coming Soon"),
    )
  ];

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
      appBar: null,
      backgroundColor: Colors.white,
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFFC7C6CA),
        selectedItemColor: const Color(0xFF0E6927),
        unselectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFFC7C6CA),
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0E6927),
        ),
        currentIndex: currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    currentIndex == 0 ? listAssets[3] : listAssets[0],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    currentIndex == 1 ? listAssets[4] : listAssets[1],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            label: "Curhat",
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    currentIndex == 2 ? listAssets[5] : listAssets[2],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                )
              ],
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
