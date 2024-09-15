import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/notification/notification_screen.dart';
import 'package:quranhealer/screens/notification/notification_view_model.dart';
import 'package:quranhealer/screens/ustadz/chat_ustadz_screen.dart';
import 'package:quranhealer/screens/ustadz/fitur_post_ustadz_screen.dart';
import 'package:quranhealer/services/ustadz_chat/ustadz_chat_service.dart';

class UstadzScreen extends StatefulWidget {
  final String nameUstadz;
  final String email;
  final String spesialisasi;
  final int userId;
  const UstadzScreen({
    super.key,
    required this.nameUstadz,
    required this.email,
    required this.spesialisasi,
    required this.userId,
  });

  @override
  State<UstadzScreen> createState() => _UstadzScreenState();
}

class _UstadzScreenState extends State<UstadzScreen> {
  late Timer timer1;
  bool _isTimerActive = false;

  @override
  void initState() {
    super.initState();

    if (!_isTimerActive) {
      _isTimerActive = true;
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          Provider.of<NotificationViewModel>(context, listen: false)
              .fetchBlmDibaca();
        } else {
          timer.cancel();
        }
      });
    }
  }

  @override
  void dispose() {
    if (_isTimerActive) {
      timer1.cancel();
      _isTimerActive = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatUstadzService _chatService = ChatUstadzService();
    return Consumer<NotificationViewModel>(builder: (context, provider, _) {
      return SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(color: Color(0xFF186D68)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 28,
                                height: 23,
                                child: Image.asset("assets/logo/logo.png"),
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
                                StreamBuilder<String>(
                                  stream: provider.blmDibacaStream,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else if (snapshot.hasError) {
                                      return Container();
                                    } else if (snapshot.hasData) {
                                      return Positioned(
                                        top: 5,
                                        right: 5,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.orange,
                                          child: Text(
                                            "${snapshot.data}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fitur Curhat Ustadz',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ustadz',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FiturUstadzPostScreen(
                                      ustadzName: widget.nameUstadz,
                                      spesialisasi: widget.spesialisasi,
                                      idUstadz: widget.email == 'aris@gmail.com'
                                          ? 79
                                          : widget.email == 'untung@gmail.com'
                                              ? 82
                                              : widget.email ==
                                                      'irfan@gmail.com'
                                                  ? 81
                                                  : widget.email ==
                                                          "suparyanto@gmail.com"
                                                      ? 80
                                                      : 68,
                                    ),
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.post_add,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Post Feature',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        widget.nameUstadz,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatUstadzScreen(
                                    email: widget.email,
                                    idUser: widget.userId,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.message,
                                        size: 40,
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Chat Feature',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            widget.nameUstadz,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  StreamBuilder(
                                    stream: _chatService.getNotfUstadzAll(
                                      widget.email,
                                      widget.userId,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Container();
                                      }
                                      if (snapshot.hasError) {
                                        return Container();
                                      }
                                      if (!snapshot.hasData ||
                                          !snapshot.data!.exists) {
                                        return Container();
                                      }
                                      int notfustadz =
                                          snapshot.data!.get('notifChat') ?? 0;
                                      return Visibility(
                                        visible: notfustadz != 0,
                                        child: SizedBox(
                                          height: 30,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            child: Text(
                                              "$notfustadz",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
