import 'package:flutter/material.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';

class MenuDashboardScreen extends StatefulWidget {
  const MenuDashboardScreen({super.key});

  @override
  State<MenuDashboardScreen> createState() => _MenuDashboardScreenState();
}

class _MenuDashboardScreenState extends State<MenuDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List Feature"),
        centerTitle: true,
        actions: const [
          Icon(Icons.menu),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF073313),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        child: Text(
                          'Explore Fitur QuranHealer',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Image.asset('assets/icons/menu/mosque.png'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 0,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/quran.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'AL-Quran',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 1,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/pray.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Doa',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 2,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/time.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Adzan',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 3,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/hadist.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Hadist',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 4,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/iqro.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Iqro',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 5,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/kisah.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Kisah Nabi',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 0,
                                currentIndex: 1,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              width: MediaQuery.of(context).size.width,
                              child: CircleAvatar(
                                backgroundColor: const Color(0xFF0E6969),
                                radius: 25,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      'assets/icons/dashboard/chat.png'),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Curhat',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
