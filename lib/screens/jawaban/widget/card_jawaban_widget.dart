// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/services/jawaban/delete_jawaban_service.dart';
import 'package:quranhealer/services/jawaban/edit_jawaban_service.dart';

class CardJawaban extends StatefulWidget {
  final String role;
  final String name;
  final bool byUser;
  final String comment;
  final int id_comment;
  final String judul;
  final String username;
  final String tanggalUpdate;
  final String jamUpdate;
  final String konten;
  final int up;
  final int down;
  final String commentCount;
  final int id_post;
  final bool? isLiked;
  final bool byUstadz;
  final String spesialisasi;
  final String ustadzName;
  final bool isUstadzPage;
  final int ustadzId;
  const CardJawaban({
    super.key,
    required this.byUser,
    required this.role,
    required this.name,
    required this.comment,
    required this.id_comment,
    required this.judul,
    required this.username,
    required this.tanggalUpdate,
    required this.jamUpdate,
    required this.konten,
    required this.up,
    required this.down,
    required this.commentCount,
    required this.id_post,
    this.isLiked,
    required this.byUstadz,
    required this.spesialisasi,
    required this.ustadzName,
    required this.isUstadzPage,
    required this.ustadzId,
  });

  @override
  State<CardJawaban> createState() => _CardJawabanState();
}

final TextEditingController jawabanEditedController = TextEditingController();

class _CardJawabanState extends State<CardJawaban> {
  bool isLoadingEdit = false;
  bool isLoadingDelete = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            widget.role == 'ustadz' ? widget.name : 'Anonymous',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Text(
                            widget.role == 'ustadz' ? 'Ustadz' : 'User',
                            style: TextStyle(
                                fontSize: 13,
                                color: widget.role == 'ustadz'
                                    ? const Color(0xFFC1881A)
                                    : Colors.black),
                          )
                        ],
                      ),
                    ],
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
              Text(widget.comment),
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  const Text('Kirim Comment'),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: jawabanEditedController,
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(5), // Bentuk border
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoadingEdit = true;
                        });
                        try {
                          await EditCommentService().editComment(
                            comment: jawabanEditedController.text,
                            idComment: widget.id_comment,
                          );
                          // await CommentService().postComment(
                          //   comment: jawabanController.text,
                          //   idPost: widget.id_post,
                          // );
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Kamu berhasil Edit Commment")));

                          // jawabanViewModel.clearJawaban();

                          setState(() {
                            isLoadingEdit = false;
                            // apiCalled = false;
                            // jawabanDataViewModel =
                            //     provider.getAllJawaban(
                            //         idPost: widget.id_post);
                            // jawabanCount = jawabanCount + 1;
                          });
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JawabanScreen(
                                judul: widget.judul,
                                commentCount:
                                    "${int.parse(widget.commentCount) - 1}",
                                down: widget.down,
                                jamUpdate: widget.jamUpdate,
                                konten: widget.konten,
                                tanggalUpdate: widget.tanggalUpdate,
                                up: widget.up,
                                username: widget.username,
                                id_post: widget.id_post,
                                byUser: widget.byUser,
                                isLiked: widget.isLiked,
                                byUstadz: widget.byUstadz,
                                isUstadzPage: widget.isUstadzPage,
                                ustadzId: widget.ustadzId,
                                ustadzName: widget.ustadzName,
                                spesialisasi: widget.spesialisasi,
                              ),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Mohon Maaf Edit Comment kamu gagal")));
                          setState(() {
                            isLoadingEdit = false;
                          });

                          Navigator.pop(context);
                        }
                      },
                      child: isLoadingEdit
                          ? const CircularProgressIndicator()
                          : const Text('Post'),
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
                setState(() {
                  isLoadingEdit = true;
                });
                try {
                  DeleteCommentService()
                      .deleteComment(idComment: widget.id_comment);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Kamu berhasil menghapus Komentar")));
                  setState(() {
                    isLoadingEdit = false;
                  });
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JawabanScreen(
                        judul: widget.judul,
                        commentCount: "${int.parse(widget.commentCount) - 1}",
                        down: widget.down,
                        jamUpdate: widget.jamUpdate,
                        konten: widget.konten,
                        tanggalUpdate: widget.tanggalUpdate,
                        up: widget.up,
                        username: widget.username,
                        id_post: widget.id_post,
                        byUser: widget.byUser,
                        isLiked: widget.isLiked,
                        byUstadz: widget.byUstadz,
                        isUstadzPage: widget.isUstadzPage,
                        ustadzId: widget.ustadzId,
                        ustadzName: widget.ustadzName,
                        spesialisasi: widget.spesialisasi,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                          "Sepertinya ada kesalahan gagal menghapus Komentar")));
                  setState(() {
                    isLoadingEdit = false;
                  });

                  Navigator.pop(context);
                }
              },
              child: isLoadingDelete
                  ? const CircularProgressIndicator()
                  : const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
