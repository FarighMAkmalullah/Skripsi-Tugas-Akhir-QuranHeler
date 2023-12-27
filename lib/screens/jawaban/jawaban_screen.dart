// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_view_model.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';
import 'package:quranhealer/services/comment/comment_sercive.dart';

// ignore: must_be_immutable
class JawabanScreen extends StatefulWidget {
  String judul;
  String username;
  String tanggalUpdate;
  String jamUpdate;
  String konten;
  int up;
  int down;
  String commentCount;
  int id_post;
  bool byUser;
  bool? isLiked;
  bool byUstadz;
  JawabanScreen({
    super.key,
    required this.judul,
    required this.commentCount,
    required this.down,
    required this.jamUpdate,
    required this.konten,
    required this.tanggalUpdate,
    required this.up,
    required this.username,
    required this.id_post,
    required this.byUser,
    required this.isLiked,
    required this.byUstadz,
  });

  @override
  State<JawabanScreen> createState() => _JawabanScreenState();
}

class _JawabanScreenState extends State<JawabanScreen> {
  late Future<void> jawabanDataViewModel;
  late int jawabanCount;

  bool apiCalled = true;
  @override
  void initState() {
    jawabanCount = int.parse(widget.commentCount);

    jawabanCount = int.parse(widget.commentCount);
    final jawabanViewModel =
        Provider.of<JawabanViewModel>(context, listen: false);
    jawabanDataViewModel =
        jawabanViewModel.getAllJawaban(idPost: widget.id_post);
    print(widget.id_post);

    // filteredQuranList = quranViewModel.quranlist;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!apiCalled) {
      final jawabanViewModel = Provider.of<JawabanViewModel>(context);
      jawabanViewModel.allJawaban.clear();
      jawabanDataViewModel =
          jawabanViewModel.getAllJawaban(idPost: widget.id_post);
      setState(() {
        apiCalled = true;
      });
    }
  }

  final TextEditingController jawabanController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final jawabanViewModel = Provider.of<JawabanViewModel>(context);
    return Consumer<JawabanViewModel>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Jawaban",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF0E6927),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UstadzPostCard(
                    byUstadz: widget.byUstadz,
                    judul: widget.judul,
                    commentCount: "$jawabanCount",
                    down: widget.down,
                    jamUpdate: widget.jamUpdate,
                    konten: widget.konten,
                    tanggalUpdate: widget.tanggalUpdate,
                    up: widget.up,
                    username: widget.username,
                    id_post: widget.id_post,
                    byUser: widget.byUser,
                    isLiked: widget.isLiked,
                  ),
                  const Divider(
                    color: Color(0xFFDEDEDE),
                    height: 5,
                    thickness: 5,
                  ),
                ],
              ),
              FutureBuilder(
                future: jawabanDataViewModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (jawabanCount <= 0) {
                      provider.clearJawaban();
                      return const Center(
                        child: Text("Belum ada jawaban"),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.allJawaban.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.allJawaban[index]!
                                                          .role ==
                                                      'ustadz'
                                                  ? provider
                                                      .allJawaban[index]!.name
                                                  : 'Anonymous',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              provider.allJawaban[index]!
                                                          .role ==
                                                      'ustadz'
                                                  ? 'Ustadz'
                                                  : 'User',
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: provider
                                                              .allJawaban[
                                                                  index]!
                                                              .role ==
                                                          'ustadz'
                                                      ? const Color(0xFFC1881A)
                                                      : Colors.black),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(provider.allJawaban[index]!.comment),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Color(0xFFDEDEDE),
                                height: 5,
                                thickness: 5,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return ErrorScreen(
                      onRefreshPressed: () {
                        provider.getAllJawaban(idPost: widget.id_post);
                      },
                    );
                  } else {
                    return ErrorScreen(
                      onRefreshPressed: () {
                        provider.getAllJawaban(idPost: widget.id_post);
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButton: widget.byUser == true || widget.byUstadz == true
            ? FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(
                          children: [
                            const Text('Kirim Comment'),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: jawabanController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Comment',
                                hintMaxLines: 5,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF888888),
                                    width: 2,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF0E6927),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Bentuk border
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    await CommentService().postComment(
                                      comment: jawabanController.text,
                                      idPost: widget.id_post,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Kamu berhasil Commment")));

                                    jawabanViewModel.clearJawaban();

                                    setState(() {
                                      isLoading = false;
                                      apiCalled = false;
                                      jawabanDataViewModel =
                                          provider.getAllJawaban(
                                              idPost: widget.id_post);
                                      jawabanCount = jawabanCount + 1;
                                    });

                                    Navigator.pop(context);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Mohon Maaf Comment kamu gagal")));
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Navigator.pop(context);
                                  }
                                },
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Post'),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                backgroundColor: const Color(0xFF0E6927),
                foregroundColor: Colors.white,
                elevation: 4.0,
                child: const Icon(Icons.add),
              )
            : null,
      );
    });
  }
}
