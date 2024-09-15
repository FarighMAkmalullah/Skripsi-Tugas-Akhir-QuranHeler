// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/models/jawaban/detail_post_model.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_view_model.dart';
import 'package:quranhealer/screens/jawaban/widget/card_jawaban_widget.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
import 'package:quranhealer/services/comment/comment_sercive.dart';
import 'package:quranhealer/services/notification_input/notification_input.dart';
import 'package:quranhealer/services/notification_send/notification_send.dart';
import 'package:quranhealer/services/post/delete_post_service.dart';

// ignore: must_be_immutable
class JawabanScreen extends StatefulWidget {
  int id_post;
  bool byUstadz;
  bool byUser;
  VoidCallback onDeleteNavigation;
  VoidCallback onDelete;
  JawabanScreen({
    super.key,
    required this.id_post,
    required this.byUser,
    required this.byUstadz,
    required this.onDelete,
    required this.onDeleteNavigation,
  });

  @override
  State<JawabanScreen> createState() => _JawabanScreenState();
}

class _JawabanScreenState extends State<JawabanScreen> {
  // late Future<void> jawabanDataViewModel;

  final formKey = GlobalKey<FormState>();

  bool apiCalled = true;
  @override
  void initState() {
    _jawabanViewModel = Provider.of<JawabanViewModel>(context, listen: false);
    _jawabanViewModel.clearPostController();
    _jawabanViewModel.cancelTimer();
    Provider.of<JawabanViewModel>(context, listen: false).streamAllPostData(
      idPost: widget.id_post,
    );

    print("id post : ${widget.id_post}");

    _jawabanViewModel.streamCommentPostData(
      idPost: widget.id_post,
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _jawabanViewModel.streamCommentPostData(
      idPost: widget.id_post,
    );

    Provider.of<JawabanViewModel>(context, listen: false).streamAllPostData(
      idPost: widget.id_post,
    );
    super.didChangeDependencies();
  }

  String tanggalUpdate(data) {
    DateTime dateTime = DateTime.parse(data);

    String formattedDateString =
        "${dateTime.year}/${dateTime.month}/${dateTime.day}";

    return formattedDateString;
  }

  final TextEditingController jawabanController = TextEditingController();

  final NotificationInputService _notificationService =
      NotificationInputService();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        try {
          _jawabanViewModel.clearPostController();
          try {
            _jawabanViewModel.cancelTimer();
            try {
              Navigator.pop(context);
            } catch (e) {
              return;
            }
          } catch (e) {
            return;
          }
        } catch (e) {
          return;
        }
        setState(() {});
      },
      child: Consumer2<JawabanViewModel, ProfilViewModel>(
        builder: (context, provider, provider2, _) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color(0xFF186D68),
            ),
            // body: ListView(
            //   children: [
            body: StreamBuilder<PostDetail>(
              stream: provider.personalPostStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return ErrorScreen(onRefreshPressed: () {
                    provider.streamAllPostData(idPost: widget.id_post);
                  });
                } else if (!snapshot.hasData) {
                  Future.delayed(const Duration(seconds: 5), () {
                    provider.streamAllPostData(idPost: widget.id_post);
                  });
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  PostDetail personalPostData = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UstadzPostCard(
                        byUstadz: widget.byUstadz,
                        judul: personalPostData.judul,
                        commentCount: personalPostData.commentCount,
                        down: int.parse(personalPostData.down),
                        konten: personalPostData.konten,
                        tanggalUpdate:
                            tanggalUpdate(personalPostData.updatedAt),
                        up: int.parse(personalPostData.up),
                        username: personalPostData.username,
                        id_post: personalPostData.idPost,
                        byUser: personalPostData.byUser,
                        isLiked: personalPostData.isLiked,
                        ustadzId: personalPostData.idUserUstadz,
                        jawaban: true,
                        onDelete: () async {
                          try {
                            await DeletePostService().deletePost(
                              idPost: personalPostData.idPost,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Kamu berhasil Hapus Post")));
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BottomBar(
                                    dashboardIndex: 0, currentIndex: 1),
                              ),
                              (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    "Sepertinya ada kesalahan gagal Hapus Post"),
                              ),
                            );
                          }
                        },
                        context: context,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        child: Text(
                          'Jawaban',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: StreamBuilder(
                            stream: provider.commentPostStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                if (int.parse(personalPostData.commentCount) ==
                                    0) {
                                  return const Center(
                                    child: Text("Belum ada Jawaban..."),
                                  );
                                }
                                return ErrorScreen(onRefreshPressed: () {
                                  provider.streamAllPostData(
                                      idPost: widget.id_post);
                                });
                              } else if (!snapshot.hasData) {
                                Future.delayed(const Duration(seconds: 5), () {
                                  provider.streamAllPostData(
                                      idPost: widget.id_post);
                                });
                                return Container(
                                  height: 150,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else {
                                List<Comment> allPostData = snapshot.data ?? [];
                                return allPostData.isEmpty
                                    ? Container(
                                        height: 150,
                                        child: const Center(
                                          child: Text('Belum ada Jawaban'),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: allPostData.length,
                                        itemBuilder: (context, index) {
                                          return CardJawaban(
                                            byUser: widget.byUser,
                                            role: allPostData[index].role,
                                            name: allPostData[index].name,
                                            comment: allPostData[index].comment,
                                            id_comment:
                                                allPostData[index].idComment,
                                          );
                                        },
                                      );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  );
                }
              },
            ),
            floatingActionButton: widget.byUser == true ||
                    widget.byUstadz == true
                ? FloatingActionButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: Wrap(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFD9D9D9),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: const Icon(
                                                Icons.person,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                controller: jawabanController,
                                                validator: (value) {
                                                  if (value != null &&
                                                      value.length < 5) {
                                                    return 'Enter min. 5 characters';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Jawab',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xFF888888),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 5),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            provider2.detailUser!.role ==
                                                    'ustadz'
                                                ? StreamBuilder(
                                                    stream: _notificationService
                                                        .getTokenUserSteam(
                                                            provider2
                                                                .detailUser!
                                                                .user_id),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        return const CircularProgressIndicator();
                                                      } else if (snapshot
                                                          .hasError) {
                                                        return MyButton(context,
                                                            provider, () {});
                                                      } else if (!snapshot
                                                              .hasData ||
                                                          snapshot
                                                              .data!.isEmpty) {
                                                        return MyButton(context,
                                                            provider, () {});
                                                      }
                                                      final tokens =
                                                          snapshot.data!;
                                                      return MyButton(
                                                        context,
                                                        provider,
                                                        () async {
                                                          for (var tokenMap
                                                              in tokens) {
                                                            final token =
                                                                tokenMap[
                                                                    'token'];
                                                            try {
                                                              NotificationSend()
                                                                  .send(
                                                                tokenMobile:
                                                                    token,
                                                                judul:
                                                                    'Notifikasi Post',
                                                                body:
                                                                    'Anda Mendapatkan Jawaban Dari Post Anda',
                                                                to: 'user',
                                                                emailUstadz: '',
                                                                idUstadz: 0,
                                                              );
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      "Kamu berhasil Send Notification"),
                                                                ),
                                                              );
                                                            } catch (e) {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                const SnackBar(
                                                                  content: Text(
                                                                      "Gagal Send Notification"),
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        },
                                                      );
                                                    },
                                                  )
                                                : MyButton(
                                                    context,
                                                    provider,
                                                    () {},
                                                  ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    backgroundColor: const Color(0xFF186D68),
                    foregroundColor: Colors.white,
                    elevation: 4.0,
                    child: const Icon(Icons.send),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget MyButton(
      BuildContext context, JawabanViewModel provider, VoidCallback onTap) {
    return IconButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            try {
              await CommentService().postComment(
                comment: jawabanController.text,
                idPost: widget.id_post,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Kamu berhasil Commment")));

              setState(() {
                isLoading = false;
                apiCalled = false;
                jawabanController.text = '';
              });

              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Mohon Maaf Comment kamu gagal")));
              setState(() {
                isLoading = false;
              });

              Navigator.pop(context);
            }
          }
        },
        icon: const Icon(Icons.send));
  }

  late JawabanViewModel _jawabanViewModel;
}
