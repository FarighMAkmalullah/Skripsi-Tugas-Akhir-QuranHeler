// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:quranhealer/models/jawaban/detail_post_model.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';
import 'package:quranhealer/services/post/add_post_service.dart';
import 'package:quranhealer/services/post/delete_post_service.dart';

// ignore: must_be_immutable
class FiturUstadzPostScreen extends StatefulWidget {
  String ustadzName;
  String spesialisasi;
  int idUstadz;
  FiturUstadzPostScreen({
    super.key,
    required this.ustadzName,
    required this.spesialisasi,
    required this.idUstadz,
  });

  @override
  State<FiturUstadzPostScreen> createState() => _UstadzPostScreenState();
}

class _UstadzPostScreenState extends State<FiturUstadzPostScreen> {
  late Future<void> postDataViewModel;

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

  bool ApiCalled = false;

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
        ),
      ),
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
