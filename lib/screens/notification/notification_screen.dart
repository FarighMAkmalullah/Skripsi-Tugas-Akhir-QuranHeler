// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/models/notification/notification_model.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/screens/notification/notification_view_model.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:quranhealer/services/notification/notification_read_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<void> postDataViewModel;

  String tanggalUpdate(data) {
    DateTime dateTime = DateTime.parse(data);

    String formattedDateString =
        "${dateTime.year}/${dateTime.month}/${dateTime.day}";

    return formattedDateString;
  }

  String formatLine(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }

  String tanggalDate(DateTime tanggal) {
    DateTime originalDate = tanggal;
    String formattedDate =
        "${originalDate.day.toString().padLeft(2, '0')} ${_getMonthName(originalDate.month)} ${originalDate.year} - ${originalDate.hour.toString().padLeft(2, '0')}:${originalDate.minute.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  String _getMonthName(int month) {
    List<String> monthNames = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];

    return monthNames[month - 1];
  }

  late Timer timer1;
  bool _isTimerActive = false;
  @override
  void initState() {
    super.initState();

    if (!_isTimerActive) {
      timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
        Provider.of<NotificationViewModel>(context, listen: false)
            .getNotificationData();
      });
    }
  }

  String jamUpdate(data) {
    DateTime dateTime = DateTime.parse(data);

    String formattedTimeString = DateFormat('HH:mm').format(dateTime);

    return formattedTimeString;
  }

  @override
  void dispose() {
    super.dispose();
    timer1.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification Post",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF186D68),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: Consumer2<NotificationViewModel, AllPostViewModel>(
        builder: (
          context,
          provider,
          provider2,
          _,
        ) {
          return StreamBuilder(
              stream: provider.notificationStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: ErrorScreen(onRefreshPressed: () {
                      provider.notificationStream;
                    }),
                  );
                } else {
                  List<NotificationModel> notificationData =
                      snapshot.data ?? [];
                  if (notificationData.isEmpty) {
                    return const Center(
                      child: Text('Belum Ada Notifikasi'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: notificationData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        int reversedIndex = notificationData.length - index - 1;
                        if (notificationData[reversedIndex].idPost != -1) {
                          return InkWell(
                            onTap: () async {
                              try {
                                var res = await NotivicationReadService
                                    .fetchNotificationReadData(
                                        idNotif: notificationData[reversedIndex]
                                            .idNotif);
                                if (res.containsKey('result')) {
                                  log('Berhasil');
                                } else {
                                  log('Gagal');
                                }
                              } catch (e) {
                                log("$e");
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JawabanScreen(
                                      id_post: notificationData[reversedIndex]
                                          .idPost,
                                      byUser: true,
                                      byUstadz: false,
                                      onDelete: () {},
                                      onDeleteNavigation: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const NotificationScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  )).then(
                                (value) => setState(
                                  () {},
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: notificationData[reversedIndex].isRead
                                    ? Colors.transparent
                                    : Colors.black12,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              // '${notificationData[reversedIndex].isRead}',
                                              tanggalDate(notificationData[
                                                      reversedIndex]
                                                  .createdAt),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              notificationData[reversedIndex]
                                                      .isRead
                                                  ? Icons.mark_chat_read
                                                  : Icons.mark_chat_unread,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Flexible(
                                              child: Text(
                                                formatLine(notificationData[
                                                        reversedIndex]
                                                    .status),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 1,
                                    thickness: 1,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                }
              });
        },
      ),
    );
  }
}
