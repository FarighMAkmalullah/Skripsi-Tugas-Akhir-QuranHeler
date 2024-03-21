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
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/quran.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'AL-Quran',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/pray.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Doa',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/time.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Adzan',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
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
                                dashboardIndex: 3,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/hadist.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Hadist',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
                                dashboardIndex: 4,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/iqro.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Iqro',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
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
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/kisah.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Kisah Nabi',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
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
                                currentIndex: 1,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 25),
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0E6927),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15),
                                  ),
                                ),
                                child: SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                      'assets/icons/dashboard/chat.png'),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Curhat',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
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
