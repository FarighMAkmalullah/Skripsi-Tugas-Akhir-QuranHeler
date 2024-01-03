// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/services/dislike/dislike_service.dart';
import 'package:quranhealer/services/like/like_service.dart';
import 'package:quranhealer/services/post/delete_post_service.dart';
import 'package:quranhealer/services/post/edit_post_service.dart';

// ignore: must_be_immutable
class UstadzPostCard extends StatefulWidget {
  bool byUstadz;
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
  bool isUstadzPage;
  final int ustadzId;
  final String spesialisasi;
  final String ustadzName;
  UstadzPostCard({
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
    required this.isUstadzPage,
    required this.ustadzId,
    required this.spesialisasi,
    required this.ustadzName,
  });

  @override
  State<UstadzPostCard> createState() => _UstadzPostCardState();
}

class _UstadzPostCardState extends State<UstadzPostCard> {
  var isLike = null;

  late String judulPost;
  late String kontenPost;

  @override
  void dispose() {
    judulController.dispose();
    kontenController.dispose();
    super.dispose();
  }

  TextEditingController judulController = TextEditingController();
  TextEditingController kontenController = TextEditingController();
  @override
  void initState() {
    super.initState();
    judulController = TextEditingController(text: widget.judul);
    kontenController = TextEditingController(text: widget.konten);
    judulPost = widget.judul;
    kontenPost = widget.konten;
  }

  bool isLoadingEdit = false;

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
                    "$judulPost ?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  widget.byUser == true
                      ? InkWell(
                          onTap: () {
                            showPopupMenu(context);
                          },
                          child: const Icon(Icons.more_vert),
                        )
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
              Text(kontenPost),
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
                                          : widget.isLiked != true &&
                                                  isLike == true
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
                                          : widget.isLiked != true &&
                                                  isLike == true
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
                                          : widget.isLiked != false &&
                                                  isLike == false
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
                                          : widget.isLiked != false &&
                                                  isLike == false
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
                                  byUstadz: widget.byUstadz,
                                  judul: judulPost,
                                  commentCount: widget.commentCount,
                                  down: widget.down,
                                  jamUpdate: widget.jamUpdate,
                                  konten: kontenPost,
                                  tanggalUpdate: widget.tanggalUpdate,
                                  up: widget.up,
                                  username: widget.username,
                                  id_post: widget.id_post,
                                  byUser: widget.byUser,
                                  isLiked: widget.isLiked,
                                  isUstadzPage: widget.isUstadzPage,
                                  ustadzId: widget.ustadzId,
                                  ustadzName: widget.ustadzName,
                                  spesialisasi: widget.spesialisasi,
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

  void showPopupMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx + renderBox.size.width,
        offset.dy,
        offset.dx + renderBox.size.width + 150,
        offset.dy + renderBox.size.height + 50,
      ),
      items: [
        const PopupMenuItem<String>(
          value: 'edit',
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'hapus',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Hapus'),
          ),
        ),
      ],
    ).then((value) {
      // Handle pilihan dari menu pop-up (jika diperlukan)
      if (value == 'edit') {
        // Lakukan aksi untuk edit
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Edit Post'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: judulController,
                    decoration: InputDecoration(
                      hintText: widget.judul,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
                  TextFormField(
                    controller: kontenController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: widget.konten,
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoadingEdit = true;
                        });
                        try {
                          await EditPostService().postEdit(
                            judul: judulController.text,
                            konten: kontenController.text,
                            idPost: widget.id_post,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Kamu berhasil Edit Post")));
                          // provider.clearUstadzPost();
                          setState(() {
                            // postCurhat = false;
                            isLoadingEdit = false;
                            // apiCalled = false;
                            judulPost = judulController.text;
                            kontenPost = kontenController.text;
                            // postDataViewModel = provider.getUstadzPostData(
                            //     idUstadz: widget.idUstadz);
                          });
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Mohon Maaf edit Post kamu gagal")));
                          setState(() {
                            // postCurhat = false;
                            isLoadingEdit = false;
                          });
                        }

                        Navigator.pop(context);
                      },
                      child: isLoadingEdit
                          ? const CircularProgressIndicator()
                          : const Text('Edit Post'),
                    ),
                  )
                ],
              ),
            );
          },
        );
        print('Edit terpilih');
      } else if (value == 'hapus') {
        // Lakukan aksi untuk hapus
        _showAlertDialog(context);
        print('Hapus terpilih');
      }
    });
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan!'),
          content: const Text('Apakah anda yakin ingin menghapus Post?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await DeletePostService().deletePost(
                    idPost: widget.id_post,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Kamu berhasil Hapus Post")));
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BottomBar(dashboardIndex: 0, currentIndex: 1),
                      ),
                      (route) => false);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Sepertinya ada kesalahan gagal Hapus Post"),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
