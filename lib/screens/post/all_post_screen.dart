import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/screens/post/widget/ustadz_post_card.dart';

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

    filteredAllPostList = postViewModel.allPostData;

    // filteredQuranList = quranViewModel.quranlist;
    super.initState();
  }

  List filteredAllPostList = [];

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

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
        void filterAllPostList(String query) {
          final filteredList = provider.allPostData.where((post) {
            return post.judul.toLowerCase().contains(query.toLowerCase());
          }).toList();

          setState(() {
            filteredAllPostList = filteredList;
          });
        }

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
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              isSearching = true;
                            });
                            filterAllPostList(value);
                          },
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
                        itemCount: isSearching
                            ? filteredAllPostList.length
                            : provider.allPostData.length,
                        itemBuilder: (context, index) {
                          var detailPost = isSearching
                              ? filteredAllPostList[index]
                              : provider.allPostData[index];
                          return UstadzPostCard(
                            judul: detailPost.judul,
                            commentCount: detailPost.commentCount,
                            down: int.parse(detailPost.down),
                            jamUpdate: jamUpdate(detailPost.updatedAt),
                            konten: detailPost.konten,
                            tanggalUpdate: tanggalUpdate(detailPost.updatedAt),
                            up: int.parse(detailPost.up),
                            username: detailPost.username,
                            id_post: detailPost.id,
                            byUser: detailPost.byUser,
                            isLiked: detailPost.isLiked,
                            byUstadz: detailPost.byUstadz,
                            isUstadzPage: false,
                            ustadzId: 0,
                            spesialisasi: '',
                            ustadzName: '',
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
