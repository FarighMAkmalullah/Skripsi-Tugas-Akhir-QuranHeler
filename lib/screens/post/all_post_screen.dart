import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:intl/intl.dart';

class AllPostScreen extends StatefulWidget {
  const AllPostScreen({super.key});

  @override
  State<AllPostScreen> createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {
  late Future<void> postDataViewModel;
  @override
  void initState() {
    final postViewModel = Provider.of<AllPostViewModel>(context, listen: false);
    postDataViewModel = postViewModel.getAllPostData();

    // filteredQuranList = quranViewModel.quranlist;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LIST ALL POST",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF0E6927),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<AllPostViewModel>(builder: (context, provider, _) {
        return FutureBuilder(
            future: postDataViewModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 20),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Cari Post...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              contentPadding: const EdgeInsets.all(1)),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      const Divider(
                        color: Color(0xFFDEDEDE),
                        height: 5,
                        thickness: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: provider.allPostData.length,
                        itemBuilder: (context, index) {
                          var detailPost = provider.allPostData[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${detailPost!.judul} ?",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                                  detailPost.username,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                                const Text(
                                                  'User',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(tanggalUpdate(
                                                detailPost.updatedAt)),
                                            Text(jamUpdate(
                                                detailPost.updatedAt)),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(detailPost.konten),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        const Divider(
                                          thickness: 1,
                                          height: 1,
                                          color: Color(0xFFA5A5A5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                    Icons.keyboard_arrow_up),
                                                Text(
                                                  detailPost.up,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                    Icons.keyboard_arrow_down),
                                                Text(
                                                  detailPost.down,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  width: 25,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.4,
                                                    color: const Color(
                                                        0xFF8B8A8A)),
                                              ),
                                              height: 40,
                                            ),
                                            Expanded(
                                                child: Center(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          JawabanScreen(
                                                        judul: detailPost.judul,
                                                        commentCount: detailPost
                                                            .commentCount,
                                                        down: int.parse(
                                                            detailPost.down),
                                                        jamUpdate: jamUpdate(
                                                            detailPost
                                                                .updatedAt),
                                                        konten:
                                                            detailPost.konten,
                                                        tanggalUpdate:
                                                            tanggalUpdate(
                                                                detailPost
                                                                    .updatedAt),
                                                        up: int.parse(
                                                            detailPost.up),
                                                        username:
                                                            detailPost.username,
                                                        id_post: detailPost.id,
                                                        byUser:
                                                            detailPost.byUser,
                                                        isLiked:
                                                            detailPost.isLiked,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Jawaban ${detailPost.commentCount}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ))
                                          ],
                                        ),
                                      ],
                                    )
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
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return ErrorScreen(onRefreshPressed: () {
                  provider.getAllPostData();
                });
              } else {
                return ErrorScreen(onRefreshPressed: () {
                  provider.getAllPostData();
                });
              }
            });
      }),
    );
  }
}
