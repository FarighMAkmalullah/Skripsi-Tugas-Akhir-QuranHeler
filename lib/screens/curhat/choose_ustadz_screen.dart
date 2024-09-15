import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/curhat/chat_screen.dart';
import 'package:quranhealer/screens/curhat/ustadz_view_model.dart';
import 'package:quranhealer/screens/curhat/widget/uztads_card.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/notification/notification_screen.dart';
// import 'package:quranhealer/screens/notification/notification_view_model.dart';
import 'package:quranhealer/screens/post/all_post_screen.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';

class ChooseUstadzScreen extends StatefulWidget {
  const ChooseUstadzScreen({super.key});

  @override
  State<ChooseUstadzScreen> createState() => _ChooseUstadzScreenState();
}

class _ChooseUstadzScreenState extends State<ChooseUstadzScreen> {
  late Timer timer1;
  bool _isTimerActive = false;

  @override
  void initState() {
    super.initState();

    // if (!_isTimerActive) {
    //   _isTimerActive = true;
    //   timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
    //     if (mounted) {
    //       Provider.of<NotificationViewModel>(context, listen: false)
    //           .fetchBlmDibaca();
    //     } else {
    //       timer.cancel();
    //     }
    //   });
    // }

    final detailViewModel =
        Provider.of<UstadzViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getUstadzDetail();
  }

  @override
  void dispose() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
    super.dispose();
  }

  late Future detailDataFuture;

  String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return word;
      }
    }).toList();
    return capitalizedWords.join(' ');
  }

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Consumer2<UstadzViewModel, ProfilViewModel>(
        builder: (context, provider, provider2, _) {
      return FutureBuilder(
          future: detailDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                body: SafeArea(
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF0E6969).withOpacity(0.9),
                              const Color(0xFF0E6969),
                            ],
                          ),
                          // borderRadius: const BorderRadius.only(
                          //   bottomRight: Radius.circular(20),
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 28,
                                        height: 23,
                                        child:
                                            Image.asset("assets/logo/logo.png"),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        'CURHAT USTADZ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const NotificationScreen(),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: 28,
                                          height: 23,
                                          child: Image.asset(
                                              "assets/icons/dashboard/notification.png"),
                                        ),
                                        // StreamBuilder<String>(
                                        //   stream: provider3.blmDibacaStream,
                                        //   builder: (context, snapshot) {
                                        //     if (snapshot.connectionState ==
                                        //         ConnectionState.waiting) {
                                        //       return Container();
                                        //     } else if (snapshot.hasError) {
                                        //       return Container();
                                        //     } else if (snapshot.hasData) {
                                        //       return Positioned(
                                        //         top: 5,
                                        //         right: 5,
                                        //         child: CircleAvatar(
                                        //           radius: 10,
                                        //           backgroundColor:
                                        //               Colors.orange,
                                        //           child: Text(
                                        //             "${snapshot.data}",
                                        //             style: const TextStyle(
                                        //                 color: Colors.white,
                                        //                 fontSize: 10),
                                        //           ),
                                        //         ),
                                        //       );
                                        //     } else {
                                        //       return Container();
                                        //     }
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: SizedBox(
                                    height: 140,
                                    child: Image.asset(
                                      "assets/images/onboarding/onboarding4.png",
                                      fit: BoxFit.contain,
                                    )),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 10),
                                  child: Text(
                                    'Temukan Ustadz Spesialis Keinginan..',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AllPostScreen(),
                                  ));
                            },
                            child: const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Lihat Seluruh Post',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF777070)),
                                      ),
                                      Icon(Icons.chevron_right)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Divider(
                                    color: Color(0xFF8B8A8A),
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: false,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 24,
                                    child: Checkbox(
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = !isChecked;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  const Text(
                                    'Sembunyikan Username di Post Maupun Chat',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Cari Ustadz Atau Spesialisasi...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                contentPadding: const EdgeInsets.all(1),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          //======================================
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: provider.detailUstadz.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Jumlah kolom dalam grid
                                mainAxisSpacing: 10.0, // Jarak antara baris
                                crossAxisSpacing: 10.0, // Jarak antara kolom
                                childAspectRatio: 1.5 /
                                    2, // Rasio aspek dari item (lebar / tinggi)
                              ),
                              itemBuilder: (context, index) {
                                return UztadsCard(
                                  nama: capitalizeEachWord(
                                      provider.detailUstadz[index]!.name),
                                  spesialis: capitalizeEachWord(provider
                                      .detailUstadz[index]!.spesialisasi),
                                  idUstadz:
                                      provider.detailUstadz[index]!.userId,
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                floatingActionButton: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ChatScreen(),
                              ));
                        },
                        child: Container(
                          height: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 2,
                              color: const Color(0xFF186D68),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            "assets/images/chat/chat-button.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ErrorScreen(onRefreshPressed: () {
                  provider.getUstadzDetail();
                }),
              );
            } else {
              return Container();
            }
          });
    });
  }
}
