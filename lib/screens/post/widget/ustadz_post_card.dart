// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/services/dislike/dislike_service.dart';
import 'package:quranhealer/services/like/like_service.dart';
import 'package:quranhealer/services/post/edit_post_service.dart';

// ignore: must_be_immutable
class UstadzPostCard extends StatefulWidget {
  bool byUstadz;
  String judul;
  String username;
  String tanggalUpdate;
  String konten;
  int up;
  int down;
  String commentCount;
  int id_post;
  bool byUser;
  bool? isLiked;
  final int ustadzId;
  bool jawaban;
  VoidCallback onDelete;
  BuildContext context;
  UstadzPostCard({
    super.key,
    required this.judul,
    required this.commentCount,
    required this.down,
    required this.konten,
    required this.tanggalUpdate,
    required this.up,
    required this.username,
    required this.id_post,
    required this.byUser,
    required this.isLiked,
    required this.byUstadz,
    required this.ustadzId,
    required this.jawaban,
    required this.onDelete,
    required this.context,
  });

  @override
  State<UstadzPostCard> createState() => _UstadzPostCardState();
}

class _UstadzPostCardState extends State<UstadzPostCard> {
  var isLike = null;

  final formKey = GlobalKey<FormState>();

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
                  widget.byUser || widget.byUstadz == true
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.tanggalUpdate),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(kontenPost),
              ),
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
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
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
                                        const SnackBar(
                                            content: Text("loading..")));
                                    LikeService()
                                        .likeAdd(idPost: widget.id_post);

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
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      color: widget.isLiked == true &&
                                              isLike == true
                                          ? Colors.blue
                                          : widget.isLiked == false &&
                                                  isLike == true
                                              ? Colors.blue
                                              : widget.isLiked == true &&
                                                      isLike == null
                                                  ? Colors.blue
                                                  : widget.isLiked != true &&
                                                          isLike == true
                                                      ? Colors.blue
                                                      : Colors.black45,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                isLike == true && widget.isLiked != true
                                    ? "${widget.up + 1}"
                                    : isLike == false && widget.isLiked == true
                                        ? "${widget.up - 1}"
                                        : "${widget.up}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      widget.isLiked == true && isLike == true
                                          ? Colors.blue
                                          : widget.isLiked == false &&
                                                  isLike == true
                                              ? Colors.blue
                                              : widget.isLiked == true &&
                                                      isLike == null
                                                  ? Colors.blue
                                                  : widget.isLiked != true &&
                                                          isLike == true
                                                      ? Colors.blue
                                                      : Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Like',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      widget.isLiked == true && isLike == true
                                          ? Colors.blue
                                          : widget.isLiked == false &&
                                                  isLike == true
                                              ? Colors.blue
                                              : widget.isLiked == true &&
                                                      isLike == null
                                                  ? Colors.blue
                                                  : widget.isLiked != true &&
                                                          isLike == true
                                                      ? Colors.blue
                                                      : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 10,
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
                                        const SnackBar(
                                            content: Text("loading..")));
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
                                  Icons.thumb_down,
                                  color:
                                      widget.isLiked == false && isLike == false
                                          ? Colors.red
                                          : widget.isLiked == true &&
                                                  isLike == false
                                              ? Colors.red
                                              : widget.isLiked == false &&
                                                      isLike == null
                                                  ? Colors.red
                                                  : widget.isLiked != false &&
                                                          isLike == false
                                                      ? Colors.red
                                                      : Colors.black45,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                isLike == false && widget.isLiked != false
                                    ? "${widget.down + 1}"
                                    : isLike == true && widget.isLiked == false
                                        ? "${widget.down - 1}"
                                        : "${widget.down}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      widget.isLiked == false && isLike == false
                                          ? Colors.red
                                          : widget.isLiked == true &&
                                                  isLike == false
                                              ? Colors.red
                                              : widget.isLiked == false &&
                                                      isLike == null
                                                  ? Colors.red
                                                  : widget.isLiked != false &&
                                                          isLike == false
                                                      ? Colors.red
                                                      : Colors.black45,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Dislike',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      widget.isLiked == false && isLike == false
                                          ? Colors.red
                                          : widget.isLiked == true &&
                                                  isLike == false
                                              ? Colors.red
                                              : widget.isLiked == false &&
                                                      isLike == null
                                                  ? Colors.red
                                                  : widget.isLiked != false &&
                                                          isLike == false
                                                      ? Colors.red
                                                      : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                          // decoration: BoxDecoration(
                          //   border: Border.all(
                          //       width: 0.4, color: const Color(0xFF8B8A8A)),
                          // ),
                          // height: 50,
                          ),
                      Expanded(
                          child: Center(
                        child: InkWell(
                          onTap: widget.jawaban
                              ? () {}
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JawabanScreen(
                                        id_post: widget.id_post,
                                        byUser: widget.byUser,
                                        byUstadz: widget.byUstadz,
                                        onDelete: () {},
                                        onDeleteNavigation: () {
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BottomBar(
                                                      dashboardIndex: 0,
                                                      currentIndex: 1),
                                            ),
                                            (route) => false,
                                          );
                                        },
                                      ),
                                    ),
                                  ).then((value) => setState(() {}));
                                },
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.comment,
                                    size: 20,
                                    color: Colors.black45,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Jawaban",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(' ${widget.commentCount}'),
                                ],
                              ),
                            ],
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
          height: 10,
          thickness: 10,
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
        widget.byUser
            ? const PopupMenuItem<String>(
                value: 'edit',
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
              )
            : const PopupMenuItem<String>(
                child: null,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Anonymous",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "Edit Post",
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
                          FractionallySizedBox(
                            widthFactor: 1.0,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFF186D68),
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
                                if (formKey.currentState!.validate()) {
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
                                            content: Text(
                                                "Kamu berhasil Edit Post")));
                                    setState(() {
                                      isLoadingEdit = false;
                                      judulPost = judulController.text;
                                      kontenPost = kontenController.text;
                                    });
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Mohon Maaf edit Post kamu gagal")));
                                    setState(() {
                                      // postCurhat = false;
                                      isLoadingEdit = false;
                                    });
                                  }

                                  Navigator.pop(context);
                                }
                              },
                              child: isLoadingEdit
                                  ? const CircularProgressIndicator()
                                  : const Icon(Icons.send),
                            ),
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

        print('Edit terpilih');
      } else if (value == 'hapus') {
        // Lakukan aksi untuk hapus
        _showAlertDialog(context);
        print('Hapus terpilih');
      }
    });
  }

  bool _isLoading = false;

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
                setState(() {
                  _isLoading = true;
                });
                widget.onDelete();
                Navigator.pop(context);
              },
              child: _isLoading ? const Text('Loading') : const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
