// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quranhealer/screens/jawaban/jawaban_screen.dart';
import 'package:quranhealer/services/jawaban/delete_jawaban_service.dart';
import 'package:quranhealer/services/jawaban/edit_jawaban_service.dart';

class CardJawaban extends StatefulWidget {
  final String role;
  final String name;
  final bool byUser;
  final String comment;
  final int id_comment;
  const CardJawaban({
    super.key,
    required this.byUser,
    required this.role,
    required this.name,
    required this.comment,
    required this.id_comment,
  });

  @override
  State<CardJawaban> createState() => _CardJawabanState();
}

class _CardJawabanState extends State<CardJawaban> {
  final TextEditingController jawabanEditedController = TextEditingController();
  bool isLoadingEdit = false;
  bool isLoadingDelete = false;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    jawabanEditedController.dispose();
    super.dispose();
  }

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
                      widget.role == 'ustadz'
                          ? SizedBox(
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                "assets/images/chat/chat-account-ustadz.png",
                                fit: BoxFit.contain,
                              ),
                            )
                          : Container(
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
                  widget.byUser == true && widget.role != 'ustadz'
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
        setState(() {
          jawabanEditedController.text = widget.comment;
        });
        // Lakukan aksi untuk edit
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Wrap(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Form(
                      key: formKey,
                      child: Column(
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
                              Expanded(
                                child: TextFormField(
                                  controller: jawabanEditedController,
                                  validator: (value) {
                                    if (value != null && value.length < 5) {
                                      return 'Enter min. 5 characters';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Jawab',
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
                                width: 5,
                              ),
                              isLoadingEdit
                                  ? const CircularProgressIndicator()
                                  : IconButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            isLoadingEdit = true;
                                          });
                                          try {
                                            await EditCommentService()
                                                .editComment(
                                              comment:
                                                  jawabanEditedController.text,
                                              idComment: widget.id_comment,
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Kamu berhasil Edit Commment")));

                                            setState(() {
                                              isLoadingEdit = false;
                                            });
                                            Navigator.pop(context);
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Mohon Maaf Edit Comment kamu gagal")));
                                            setState(() {
                                              isLoadingEdit = false;
                                            });

                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      icon: const Icon(Icons.send),
                                    )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
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
