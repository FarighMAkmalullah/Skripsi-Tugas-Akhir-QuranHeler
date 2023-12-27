import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_view_model.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';

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
  });

  @override
  State<JawabanScreen> createState() => _JawabanScreenState();
}

class _JawabanScreenState extends State<JawabanScreen> {
  late Future<void> jawabanDataViewModel;
  @override
  void initState() {
    final jawabanViewModel =
        Provider.of<JawabanViewModel>(context, listen: false);
    jawabanDataViewModel =
        jawabanViewModel.getAllJawaban(idPost: widget.id_post);
    print(widget.id_post);

    // filteredQuranList = quranViewModel.quranlist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JawabanViewModel>(builder: (context, provider, _) {
      final jawabanViewModel = Provider.of<JawabanViewModel>(context);
      return PopScope(
        child: Scaffold(
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
                      judul: widget.judul,
                      commentCount: widget.commentCount,
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
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (provider.allJawaban.length <= 0) {
                        return Center(
                          child: Text("Belum ada Jawaban"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                        ? const Color(
                                                            0xFFC1881A)
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
        ),
      );
    });
  }
}
