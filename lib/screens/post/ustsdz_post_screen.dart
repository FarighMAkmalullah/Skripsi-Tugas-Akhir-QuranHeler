// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/models/jawaban/detail_post_model.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';
import 'package:quranhealer/services/like/like_service.dart';
import 'package:quranhealer/services/post/add_post_service.dart';

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
  bool postCurhat = false;
  late List<Post?> dataPost;

  bool apiCalled = true;
  @override
  void initState() {
    final postViewModel =
        Provider.of<UstadzPostViewModel>(context, listen: false);
    postDataViewModel =
        postViewModel.getUstadzPostData(idUstadz: widget.idUstadz);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!apiCalled) {
      final postViewModel = Provider.of<UstadzPostViewModel>(context);
      postDataViewModel =
          postViewModel.getUstadzPostData(idUstadz: widget.idUstadz);
      setState(() {
        apiCalled = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    judulController.dispose();
    kontenController.dispose();
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

  @override
  Widget build(BuildContext context) {
    final postViewModel = Provider.of<UstadzPostViewModel>(context);
    return SafeArea(
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
                  color: Color(0xFF0E6927),
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
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
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
                    const Icon(
                      Icons.post_add,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 66,
              right: 0,
              left: 0,
              bottom: 0,
              child: SingleChildScrollView(
                child: Consumer<UstadzPostViewModel>(
                    builder: (context, provider, _) {
                  return FutureBuilder(
                      future: postDataViewModel,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
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
                                          child: TextField(
                                            decoration: InputDecoration(
                                              hintText: 'Cari Post...',
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(1),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 2,
                                              color: Colors.black,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                postCurhat = !postCurhat;
                                              });
                                            },
                                            child: const Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: postCurhat,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          children: [
                                            const Text('Kirim Post'),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: judulController,
                                              decoration: InputDecoration(
                                                hintText: 'Judul',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF888888),
                                                    width: 2,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 1),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              controller: kontenController,
                                              maxLines: 5,
                                              decoration: InputDecoration(
                                                hintText: 'Keterangan',
                                                hintMaxLines: 5,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  borderSide: const BorderSide(
                                                    color: Color(0xFF888888),
                                                    width: 2,
                                                  ),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            FractionallySizedBox(
                                              widthFactor: 1,
                                              child: ElevatedButton(
                                                style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    const Color(0xFF0E6927),
                                                  ),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5), // Bentuk border
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    isLoading = true;
                                                  });
                                                  try {
                                                    await AddPostService()
                                                        .postAdd(
                                                            judul:
                                                                judulController
                                                                    .text,
                                                            konten:
                                                                kontenController
                                                                    .text,
                                                            idUstadz: widget
                                                                .idUstadz);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Kamu berhasil Post")));

                                                    setState(() {
                                                      postCurhat = false;
                                                      isLoading = false;
                                                      apiCalled = false;
                                                      postDataViewModel = provider
                                                          .getUstadzPostData();
                                                    });
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    "Mohon Maaf Post kamu gagal")));
                                                    setState(() {
                                                      postCurhat = false;
                                                      isLoading = false;
                                                    });
                                                  }
                                                },
                                                child: isLoading
                                                    ? const CircularProgressIndicator()
                                                    : const Text('Post'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
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
                                itemCount: provider.allUstadzData.length,
                                itemBuilder: (context, index) {
                                  var detailPost =
                                      postViewModel.allUstadzData[index];
                                  return UstadzPostCard(
                                    byUstadz: detailPost!.byUstadz,
                                    judul: detailPost.judul,
                                    commentCount: detailPost.commentCount,
                                    down: int.parse(detailPost.down),
                                    jamUpdate: jamUpdate(detailPost.updatedAt),
                                    konten: detailPost.konten,
                                    tanggalUpdate:
                                        tanggalUpdate(detailPost.updatedAt),
                                    up: int.parse(detailPost.up),
                                    username: detailPost.username,
                                    id_post: detailPost.id,
                                    byUser: detailPost.byUser,
                                    isLiked: detailPost.isLiked,
                                  );
                                },
                              ),
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return ErrorScreen(onRefreshPressed: () {
                            provider.getUstadzPostData();
                          });
                        } else {
                          return ErrorScreen(onRefreshPressed: () {
                            provider.getUstadzPostData();
                          });
                        }
                      });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
