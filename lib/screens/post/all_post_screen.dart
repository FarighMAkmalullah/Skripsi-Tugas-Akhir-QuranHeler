import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/models/post/post_model.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';
import 'package:quranhealer/services/post/delete_post_service.dart';

class AllPostScreen extends StatefulWidget {
  const AllPostScreen({super.key});

  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {
  late Future<void> postDataViewModel;

  bool _isLoading = false;

  bool _isFiltring = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    try {
      Provider.of<AllPostViewModel>(context, listen: false)
          .clearPostController();
      try {
        Provider.of<AllPostViewModel>(context, listen: false).cancelTimer();
        try {
          Provider.of<AllPostViewModel>(context, listen: false)
              .streamAllPostData();
        } catch (e) {
          return;
        }
      } catch (e) {
        return;
      }
    } catch (e) {
      return;
    }
    super.initState();
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
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        try {
          Provider.of<AllPostViewModel>(context, listen: false)
              .clearPostController();
          try {
            Provider.of<AllPostViewModel>(context, listen: false).cancelTimer();
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
        appBar: AppBar(
          title: const Text(
            "List All Post",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF186D68),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inbox),
              onPressed: () {},
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            try {
              Provider.of<AllPostViewModel>(context, listen: false)
                  .clearPostController();
              try {
                Provider.of<AllPostViewModel>(context, listen: false)
                    .cancelTimer();
                try {
                  Provider.of<AllPostViewModel>(context, listen: false)
                      .streamAllPostData();
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
          child: Consumer<AllPostViewModel>(builder: (context, provider, _) {
            return StreamBuilder(
                stream: provider.allPostStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return ErrorScreen(onRefreshPressed: () {
                      provider.allPostStream;
                    });
                  } else {
                    List<Post> allPostData = snapshot.data ?? [];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _isLoading = false;
                                    _isFiltring = false;
                                  });
                                  Provider.of<AllPostViewModel>(context,
                                          listen: false)
                                      .streamAllPostData();
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Cari Post...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();

                                    setState(() {
                                      _isLoading = true;
                                      _isFiltring = true;
                                    });
                                    Provider.of<AllPostViewModel>(context,
                                            listen: false)
                                        .cancelTimer();
                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (_searchController.text.isEmpty) {
                                        setState(() {
                                          _isFiltring = false;
                                        });
                                        Provider.of<AllPostViewModel>(context,
                                                listen: false)
                                            .streamAllPostData();
                                      }
                                      Provider.of<AllPostViewModel>(context,
                                              listen: false)
                                          .filterAllPostData(
                                              _searchController.text);
                                    });
                                  },
                                ),
                                contentPadding: const EdgeInsets.all(10),
                              ),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const Divider(
                            color: Color(0xFFDEDEDE),
                            height: 10,
                            thickness: 10,
                          ),
                          allPostData.isEmpty
                              ? const Center(
                                  child: Text('Belum ada Post'),
                                )
                              : _isLoading == true
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.5,
                                      child: const Center(
                                          child: CircularProgressIndicator()))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: allPostData.length,
                                      itemBuilder: (context, index) {
                                        var detailPost = allPostData[index];
                                        return UstadzPostCard(
                                          judul: detailPost.judul,
                                          commentCount: detailPost.commentCount,
                                          down: int.parse(detailPost.down),
                                          konten: detailPost.konten,
                                          tanggalUpdate: tanggalUpdate(
                                              detailPost.updatedAt),
                                          up: int.parse(detailPost.up),
                                          username: detailPost.username,
                                          id_post: detailPost.id,
                                          byUser: detailPost.byUser,
                                          isLiked: detailPost.isLiked,
                                          byUstadz: detailPost.byUstadz,
                                          ustadzId: 0,
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

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Kamu berhasil Hapus Post")));
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Sepertinya ada kesalahan gagal Hapus Post"),
                                                ),
                                              );
                                            }
                                            try {
                                              Provider.of<AllPostViewModel>(
                                                      context,
                                                      listen: false)
                                                  .clearPostController();
                                              try {
                                                Provider.of<AllPostViewModel>(
                                                        context,
                                                        listen: false)
                                                    .cancelTimer();
                                                try {
                                                  Provider.of<AllPostViewModel>(
                                                          context,
                                                          listen: false)
                                                      .streamAllPostData();
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2), () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AllPostScreen(),
                                                      ),
                                                    );
                                                  });
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
                      ),
                    );
                  }
                });
          }),
        ),
      ),
    );
  }
}
