import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/screens/notification/notification_view_model.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:quranhealer/services/notification/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late Future<void> notificationDataViewModel;
  late Future<void> postDataViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final notificationViewModel =
        Provider.of<NotificationViewModel>(context, listen: false);
    notificationDataViewModel = notificationViewModel.getNotificationPostData();

    final postViewModel = Provider.of<AllPostViewModel>(context, listen: false);
    postDataViewModel = postViewModel.getAllPostData();
  }

  String dateTime(params) {
    DateTime originalDate = DateTime.parse(params);

    // Format DateTime to desired string
    String formattedDate =
        "${originalDate.year}-${_addLeadingZero(originalDate.month)}-${_addLeadingZero(originalDate.day)}";
    return formattedDate;
  }

  String _addLeadingZero(int value) {
    // Helper function to add leading zero if needed
    return value.toString().padLeft(2, '0');
  }

  String tanggalUpdate(data) {
    DateTime dateTime = DateTime.parse(data);

    String formattedDateString =
        "${dateTime.year}/${dateTime.month}/${dateTime.day}";

    return formattedDateString;
  }

  String jamUpdate(data) {
    DateTime dateTime = DateTime.parse(data);

    String formattedTimeString = DateFormat('HH:mm').format(dateTime);

    return formattedTimeString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF0E6927),
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
          return FutureBuilder(
            future: notificationDataViewModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return ErrorScreen(onRefreshPressed: () {
                  provider.getNotificationPostData();
                });
              } else if (snapshot.connectionState == ConnectionState.done) {
                return FutureBuilder(
                    future: postDataViewModel,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return ErrorScreen(onRefreshPressed: () {
                          provider.getNotificationPostData();
                        });
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        return ListView.builder(
                          itemCount: provider.notificationData.length,
                          itemBuilder: (context, index) {
                            var detailData = provider.notificationData[index]!;
                            var post = provider2.getPostById(detailData.idPost);
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (post != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => JawabanScreen(
                                                judul: post!.judul,
                                                commentCount: post.commentCount,
                                                down: int.parse(post.down),
                                                jamUpdate:
                                                    jamUpdate(post.updatedAt),
                                                konten: post.konten,
                                                tanggalUpdate: tanggalUpdate(
                                                    post.updatedAt),
                                                up: int.parse(post.up),
                                                username: post.username,
                                                id_post: post.id,
                                                byUser: post.byUser,
                                                isLiked: post.isLiked,
                                                byUstadz: post.byUstadz,
                                                isUstadzPage: false,
                                                ustadzId: post.idUserUstadz,
                                                ustadzName: '',
                                                spesialisasi: ''),
                                          ));
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: Colors.blueGrey[100],
                                          ),
                                          child: detailData!.isRead
                                              ? const Icon(
                                                  Icons.notifications_none)
                                              : const Icon(
                                                  Icons.notifications_active),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(detailData.status),
                                            Text(
                                                dateTime(detailData.createdAt)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return ErrorScreen(onRefreshPressed: () {
                          provider.getNotificationPostData();
                        });
                      }
                    });
              } else {
                return const Text("data");
              }
            },
          );
        },
      ),
    );
  }
}
