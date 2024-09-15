// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/core/init/untils/firebase_api.dart';
// import 'package:quranhealer/models/jawaban/detail_post_model.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';
import 'package:quranhealer/services/notification_input/notification_input.dart';
import 'package:quranhealer/services/notification_send/notification_send.dart';
import 'package:quranhealer/services/post/add_post_service.dart';
import 'package:quranhealer/services/post/delete_post_service.dart';

// ignore: must_be_immutable
class UstadzPostScreen extends StatefulWidget {
  String ustadzName;
  String spesialisasi;
  int idUstadz;
  UstadzPostScreen({
    super.key,
    required this.ustadzName,
    required this.spesialisasi,
    required this.idUstadz,
  });

  @override
  State<UstadzPostScreen> createState() => _UstadzPostScreenState();
}

class _UstadzPostScreenState extends State<UstadzPostScreen> {
  late Future<void> postDataViewModel;

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool _isFiltring = false;
  final TextEditingController _searchController = TextEditingController();

  bool postCurhat = false;
  late List<Post?> dataPost;

  bool apiCalled = true;
  @override
  void initState() {
    Provider.of<UstadzPostViewModel>(context, listen: false)
        .clearPostController();
    Provider.of<UstadzPostViewModel>(context, listen: false).cancelTimer();
    Provider.of<UstadzPostViewModel>(context, listen: false)
        .streamUstadzPostData(idUstadz: widget.idUstadz);

    super.initState();
  }

  final TextEditingController judulController = TextEditingController();
  final TextEditingController kontenController = TextEditingController();

  bool isLoading = false;

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

  Widget MyButton(
    BuildContext context,
    UstadzPostViewModel provider,
    VoidCallback onTap,
  ) {
    return FractionallySizedBox(
      widthFactor: 1.0,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            const Color(0xFF186D68),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Bentuk border
            ),
          ),
        ),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });
            try {
              await AddPostService().postAdd(
                  judul: judulController.text,
                  konten: kontenController.text,
                  idUstadz: widget.idUstadz);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Kamu berhasil Post Pertanyaan")));
              onTap();

              // provider.clearUstadzPost();
              try {
                Provider.of<UstadzPostViewModel>(context, listen: false)
                    .clearPostController();
                try {
                  Provider.of<UstadzPostViewModel>(context, listen: false)
                      .cancelTimer();
                  try {
                    Provider.of<UstadzPostViewModel>(context, listen: false)
                        .streamUstadzPostData(idUstadz: widget.idUstadz);
                  } catch (e) {
                    return;
                  }
                } catch (e) {
                  return;
                }
              } catch (e) {
                return;
              }

              setState(() {
                postCurhat = false;
                isLoading = false;
                apiCalled = false;
              });
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Mohon Maaf Post kamu gagal")));
              setState(
                () {
                  postCurhat = false;
                  isLoading = false;
                },
              );
            }
          }
        },
        child: isLoading
            ? const CircularProgressIndicator()
            : const Icon(Icons.send),
      ),
    );
  }

  void sendTokenNotification(
    int userId,
    String role,
    String email,
  ) async {}

  bool ApiCalled = false;

  final NotificationInputService _notificationService =
      NotificationInputService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) {
            return;
          }
          try {
            Provider.of<UstadzPostViewModel>(context, listen: false)
                .clearPostController();
            try {
              Provider.of<UstadzPostViewModel>(context, listen: false)
                  .cancelTimer();
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
        child: Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF186D68),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: Image.asset(
                                "assets/images/chat/chat-account-ustadz.png"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ustadzName,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                widget.spesialisasi,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.all_inbox,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              RefreshIndicator(
                onRefresh: () async {
                  try {
                    Provider.of<UstadzPostViewModel>(context, listen: false)
                        .clearPostController();
                    try {
                      Provider.of<UstadzPostViewModel>(context, listen: false)
                          .cancelTimer();
                      try {
                        Provider.of<UstadzPostViewModel>(context, listen: false)
                            .streamUstadzPostData(idUstadz: widget.idUstadz);
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
                child: Positioned(
                  top: 66,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: SingleChildScrollView(
                    child: Consumer<UstadzPostViewModel>(
                      builder: (context, provider, _) {
                        return StreamBuilder(
                          stream: Provider.of<UstadzPostViewModel>(context,
                                  listen: false)
                              .ustadzPostStream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return ErrorScreen(onRefreshPressed: () {
                                provider.ustadzPostStream;
                              });
                            } else {
                              List<Post> ustadzPostData = snapshot.data ?? [];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFe3f0f0),
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                              child: Image.asset(
                                                "assets/icons/post/anonymous.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Expanded(
                                              child: TextField(
                                                controller: _searchController,
                                                decoration: InputDecoration(
                                                  hintText: 'Cari Post...',
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Colors.black,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets.all(10),
                                                ),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            ),
                                            IconButton(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 0, 5),
                                              icon: const Icon(Icons.search),
                                              onPressed: () {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                setState(() {
                                                  _isLoading = true;
                                                  _isFiltring = true;
                                                });
                                                Provider.of<UstadzPostViewModel>(
                                                        context,
                                                        listen: false)
                                                    .cancelTimer();
                                                Future.delayed(
                                                    const Duration(seconds: 2),
                                                    () {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  if (_searchController
                                                      .text.isEmpty) {
                                                    setState(() {
                                                      _isFiltring = false;
                                                    });
                                                    Provider.of<UstadzPostViewModel>(
                                                            context,
                                                            listen: false)
                                                        .streamUstadzPostData(
                                                            idUstadz: widget
                                                                .idUstadz);
                                                  }
                                                  Provider.of<UstadzPostViewModel>(
                                                          context,
                                                          listen: false)
                                                      .filterUstadzPostData(
                                                    _searchController.text,
                                                  );
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Color(0xFFDEDEDE),
                                    height: 10,
                                    thickness: 10,
                                  ),
                                  ustadzPostData.isEmpty
                                      ? const Center(
                                          child: Text('Belum ada Post'),
                                        )
                                      : _isLoading == true
                                          ? SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.5,
                                              child: const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: ustadzPostData.length,
                                              itemBuilder: (context, index) {
                                                var detailPost =
                                                    ustadzPostData[index];
                                                return UstadzPostCard(
                                                  byUstadz: detailPost.byUstadz,
                                                  judul: detailPost.judul,
                                                  commentCount:
                                                      detailPost.commentCount,
                                                  down: int.parse(
                                                      detailPost.down),
                                                  konten: detailPost.konten,
                                                  tanggalUpdate: tanggalUpdate(
                                                      detailPost.updatedAt),
                                                  up: int.parse(detailPost.up),
                                                  username: detailPost.username,
                                                  id_post: detailPost.id,
                                                  byUser: detailPost.byUser,
                                                  isLiked: detailPost.isLiked,
                                                  ustadzId:
                                                      detailPost.idUserUstadz,
                                                  jawaban: false,
                                                  onDelete: () async {
                                                    try {
                                                      await DeletePostService()
                                                          .deletePost(
                                                        idPost: detailPost.id,
                                                      );

                                                      // setState(() {
                                                      //   ApiCalled = true;
                                                      // });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      "Kamu berhasil Hapus Post")));

                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    } catch (e) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              "Sepertinya ada kesalahan gagal Hapus Post"),
                                                        ),
                                                      );
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    }
                                                    try {
                                                      Provider.of<UstadzPostViewModel>(
                                                              context,
                                                              listen: false)
                                                          .clearPostController();
                                                      try {
                                                        Provider.of<UstadzPostViewModel>(
                                                                context,
                                                                listen: false)
                                                            .cancelTimer();
                                                        try {
                                                          Provider.of<UstadzPostViewModel>(
                                                                  context,
                                                                  listen: false)
                                                              .streamUstadzPostData(
                                                                  idUstadz: widget
                                                                      .idUstadz);
                                                        } catch (e) {
                                                          return;
                                                        }
                                                      } catch (e) {
                                                        return;
                                                      }
                                                    } catch (e) {
                                                      return;
                                                    }
                                                  },
                                                  context: context,
                                                );
                                              },
                                            ),
                                ],
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // setState(() {
              //   postCurhat = !postCurhat;
              // });
              showAddPost(context);
            },
            backgroundColor: const Color(0xFF186D68),
            foregroundColor: Colors.white,
            elevation: 4.0,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  void showAddPost(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      builder: (BuildContext context) {
        return Consumer<UstadzPostViewModel>(
          builder: (context, provider, _) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFe3f0f0),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(
                                  "assets/icons/post/anonymous.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Anonymous",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Add Post",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Icon(
                            Icons.post_add,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: judulController,
                        validator: (value) {
                          if (value != null && value.length < 5) {
                            return 'Enter min. 5 characters';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Judul',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color(0xFF888888),
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 1),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: kontenController,
                          validator: (value) {
                            if (value != null && value.length < 5) {
                              return 'Enter min. 5 characters';
                            } else {
                              return null;
                            }
                          },
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(
                            hintText: 'Keterangan',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF888888),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      StreamBuilder(
                        stream: _notificationService
                            .getTokenUstadzSteam(widget.idUstadz),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return MyButton(context, provider, () {});
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return MyButton(context, provider, () {});
                          }
                          final tokens = snapshot.data!;
                          return MyButton(
                            context,
                            provider,
                            () async {
                              for (var tokenMap in tokens) {
                                final token = tokenMap['token'];
                                try {
                                  NotificationSend().send(
                                      tokenMobile: token,
                                      judul: 'Notifikasi Post',
                                      body:
                                          'Anda Mendapatkan Pertanyaan dari Post',
                                      to: 'ustadz',
                                      emailUstadz: '',
                                      idUstadz: widget.idUstadz);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Kamu berhasil Send Notification"),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Gagal Send Notification"),
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    judulController.dispose();
    kontenController.dispose();
    _searchController.dispose();
  }
}
