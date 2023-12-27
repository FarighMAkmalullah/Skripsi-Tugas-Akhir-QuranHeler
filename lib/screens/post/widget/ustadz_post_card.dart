import 'package:flutter/material.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/services/dislike/dislike_service.dart';
import 'package:quranhealer/services/like/like_service.dart';

// ignore: must_be_immutable
class UstadzPostCard extends StatefulWidget {
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
  UstadzPostCard(
      {super.key,
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
      required this.isLiked});

  @override
  State<UstadzPostCard> createState() => _UstadzPostCardState();
}

class _UstadzPostCardState extends State<UstadzPostCard> {
  var isLike = null;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.judul} ?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  widget.byUser == true
                      ? const Icon(Icons.more_vert)
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(100),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.username,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const Text(
                            'User',
                            style: TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.tanggalUpdate),
                      Text(widget.tanggalUpdate),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(widget.konten),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLike = true;
                              });
                              try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("loading..")));
                                LikeService().likeAdd(idPost: widget.id_post);

                                setState(() {
                                  isLike = true;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Gagal Like Post")));
                                setState(() {
                                  isLike = null;
                                });
                              }
                            },
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              color: widget.isLiked == true && isLike == true
                                  ? Colors.blue
                                  : widget.isLiked == false && isLike == true
                                      ? Colors.blue
                                      : widget.isLiked == true && isLike == null
                                          ? Colors.blue
                                          : Colors.black,
                            ),
                          ),
                          Text(
                            isLike == true && widget.isLiked != true
                                ? "${widget.up + 1}"
                                : isLike == false && widget.isLiked == true
                                    ? "${widget.up - 1}"
                                    : "${widget.up}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.isLiked == true && isLike == true
                                  ? Colors.blue
                                  : widget.isLiked == false && isLike == true
                                      ? Colors.blue
                                      : widget.isLiked == true && isLike == null
                                          ? Colors.blue
                                          : Colors.black,
                            ),
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isLike = false;
                              });
                              try {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("loading..")));
                                DisLikeService()
                                    .dislikeAdd(idPost: widget.id_post);

                                setState(() {
                                  isLike = false;
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Gagal Like Post")));
                                setState(() {
                                  isLike = null;
                                });
                              }
                            },
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: widget.isLiked == false && isLike == false
                                  ? Colors.red
                                  : widget.isLiked == true && isLike == false
                                      ? Colors.red
                                      : widget.isLiked == false &&
                                              isLike == null
                                          ? Colors.red
                                          : Colors.black,
                            ),
                          ),
                          Text(
                            isLike == false && widget.isLiked != false
                                ? "${widget.down + 1}"
                                : isLike == true && widget.isLiked == false
                                    ? "${widget.down - 1}"
                                    : "${widget.down}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: widget.isLiked == false && isLike == false
                                  ? Colors.red
                                  : widget.isLiked == true && isLike == false
                                      ? Colors.red
                                      : widget.isLiked == false &&
                                              isLike == null
                                          ? Colors.red
                                          : Colors.black,
                            ),
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
                              width: 0.4, color: const Color(0xFF8B8A8A)),
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
                                builder: (context) => JawabanScreen(
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
                              ),
                            );
                          },
                          child: Text(
                            "Jawaban ${widget.commentCount}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
  }
}
