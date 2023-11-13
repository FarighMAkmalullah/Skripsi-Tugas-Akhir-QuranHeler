import 'package:flutter/material.dart';
import 'package:quranhealer/screens/adzan/adzan_screen.dart';
import 'package:quranhealer/screens/dashboard/widget/notification_widget.dart';
import 'package:quranhealer/screens/doa/doa_screen.dart';
import 'package:quranhealer/screens/quran/quran_sceen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _listFeatoreController;

  @override
  void initState() {
    super.initState();
    _listFeatoreController = TabController(length: 6, vsync: this);
    _listFeatoreController.addListener(() {
      setState(() {
        currentIndex = _listFeatoreController.index;
      });
    });
  }

  @override
  void dispose() {
    _listFeatoreController.dispose();
    super.dispose();
  }

  int currentIndex = 0;

  void _onTabChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String, dynamic> listFeature = {
    'listFeature': [
      {
        'icon': "assets/icons/dashboard/quran.png",
        'judul': 'Al-Quran',
        'deskripsi': 'Kitab Suci Al-Quran'
      },
      {
        'icon': "assets/icons/dashboard/pray.png",
        'judul': 'Daftar Doa',
        'deskripsi': 'Berisi doa-doa pilihan'
      },
      {
        'icon': "assets/icons/dashboard/time.png",
        'judul': 'Jadwal Adzan',
        'deskripsi': 'Jadwal waktu shalat'
      },
      {
        'icon': "assets/icons/dashboard/hadist.png",
        'judul': 'Hadist',
        'deskripsi': 'Hadist-Hadist pilihan'
      },
      {
        'icon': "assets/icons/dashboard/iqro.png",
        'judul': 'Iqro',
        'deskripsi': 'Pelajaran Iqro'
      },
      {
        'icon': "assets/icons/dashboard/kisah.png",
        'judul': 'Kisah Nabi',
        'deskripsi': 'Berisi Kisah-Kisah Nabi'
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 174,
              decoration: const BoxDecoration(
                color: Color(
                  0xFF0E6927,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(
                    10,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                const NotifocationWidget(),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  // height: 120,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(7, 7, 7, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0E6927),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(
                                  listFeature['listFeature'][currentIndex]
                                      ['icon'],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listFeature['listFeature'][currentIndex]
                                        ['judul'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF0E6927),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    listFeature['listFeature'][currentIndex]
                                        ['deskripsi'],
                                    overflow: TextOverflow.clip,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF3E3C3C),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          height: 1,
                          color: Color(0xFF8B8A8A),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TabBar(
                                onTap: _onTabChanged,
                                labelStyle: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                                unselectedLabelStyle: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                                indicatorWeight: 0.1,
                                indicatorColor: Colors.transparent,
                                isScrollable: true,
                                controller: _listFeatoreController,
                                labelColor: const Color(0xFF0E6927),
                                unselectedLabelColor: const Color(0xFF3E3C3C),
                                tabs: const [
                                  Tab(
                                    text: "Al-Quran",
                                  ),
                                  Tab(
                                    text: "Daftar Doa",
                                  ),
                                  Tab(
                                    text: "Jadwal Adzan",
                                  ),
                                  Tab(
                                    text: "Hadist",
                                  ),
                                  Tab(
                                    text: "Iqro",
                                  ),
                                  Tab(
                                    text: "Kisah Nabi",
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.4,
                                        color: const Color(0xFF8B8A8A)),
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 45,
                                  padding: const EdgeInsets.all(10),
                                  child: Image.asset(
                                      "assets/icons/dashboard/list.png"),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                //========================================
                Expanded(
                  child: TabBarView(
                    controller: _listFeatoreController,
                    children: const [
                      QuranScreen(),
                      DoaScreen(),
                      AdzanScreen(),
                      Center(
                        child: Text('Hadist Coming Soon'),
                      ),
                      Center(
                        child: Text('Iqro Coming Soon'),
                      ),
                      Center(
                        child: Text('Kisah Nabi Coming Soon'),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
