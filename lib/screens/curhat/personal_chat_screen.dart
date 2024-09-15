// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/models/profil/profil_model.dart';
import 'package:quranhealer/screens/curhat/widget/my_textfield_widget.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
import 'package:quranhealer/services/chat/chat_service.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/services/notification_input/notification_input.dart';
import 'package:quranhealer/services/notification_send/notification_send.dart';

class PersonalChatScreen extends StatefulWidget {
  final String email;
  final String name;
  final String spesialisasi;
  final int ustadzId;
  const PersonalChatScreen({
    super.key,
    required this.email,
    required this.name,
    required this.spesialisasi,
    required this.ustadzId,
  });

  @override
  State<PersonalChatScreen> createState() => _PersonalChatScreenState();
}

class _PersonalChatScreenState extends State<PersonalChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();

  String getTanggal(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd/MM/yyyy, HH:mm').format(dateTime);
    return formattedDate;
  }

  // for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // add listener to focus node
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      } else if (myFocusNode.nextFocus()) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // mengirimkam pesan
  void sendMessege(
    String emailuser,
    name,
    emailustadz,
    gender,
    idUstadz,
    idUser,
  ) async {
    if (_messageController.text.isNotEmpty) {
      // Kirim Pesan
      try {
        await _chatService.addUserToChatRoomUstadz(
            emailuser, name, emailustadz, 0, gender, idUstadz, idUser);
        try {
          _chatService.sendMessege(_messageController.text, emailustadz,
              emailuser, idUstadz, idUser);
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(e.toString()),
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
      _messageController.clear();
    }

    // scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      final detail = provider.detailUser;
      return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  Expanded(
                    child: _buildMessageList(detail),
                  ),
                  _buildUserInput(detail),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF186D68),
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
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: Image.asset(
                                "assets/images/chat/chat-account-ustadz.png"),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 17),
                              ),
                              Text(
                                widget.spesialisasi,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          )
                        ],
                      ),
                      const Icon(
                        Icons.message,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // build list pesan
  Widget _buildMessageList(UserData? detail) {
    return StreamBuilder(
      stream: _chatService.getMessage(
          detail!.email, widget.email, detail.user_id, widget.ustadzId, 'User'),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // menampilkan pesan
        return ListView(
          controller: _scrollController,
          children: snapshot.data!.docs
              .map((doc) => _buildMessageItem(doc, detail))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc, UserData? detail) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool isCurrentUser = data['senderID'] == detail!.user_id.toString();

    // align message to the right if sender is the current user, otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: isCurrentUser
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                margin: EdgeInsets.fromLTRB(
                    isCurrentUser ? 70 : 15, 5, isCurrentUser ? 15 : 70, 5),
                decoration: BoxDecoration(
                    color: isCurrentUser
                        ? const Color(0xFF186D68)
                        : Colors.black12,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: Radius.circular(isCurrentUser ? 15 : 0),
                      bottomRight: Radius.circular(isCurrentUser ? 0 : 15),
                    )),
                child: Text(
                  data["message"],
                  style: TextStyle(
                      color: isCurrentUser ? Colors.white : Colors.black),
                ),
              ),
              Padding(
                padding: isCurrentUser
                    ? const EdgeInsets.only(right: 15)
                    : const EdgeInsets.only(left: 15),
                child: Text(
                  getTanggal(data['timestamp']),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget MyButton(
    BuildContext context,
    UserData? detail,
    VoidCallback onTap,
  ) {
    return IconButton(
      onPressed: () {
        sendMessege(
          detail!.email,
          detail.name,
          widget.email,
          detail.gender,
          widget.ustadzId,
          detail.user_id,
        );
        scrollDown();
        myFocusNode.unfocus();
        onTap();
      },
      icon: const CircleAvatar(
        backgroundColor: Color(0xFF186D68),
        radius: 22,
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUserInput(UserData? detail) {
    final NotificationInputService _notificationService =
        NotificationInputService();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
          // color: Color.fromARGB(255, 197, 196, 196),
          ),
      child: Row(
        children: [
          Expanded(
            child: MyTextFieldWidget(
              hintText: 'Type a message',
              obscureText: false,
              controller: _messageController,
              focusNode: myFocusNode,
            ),
          ),
          StreamBuilder(
            stream: _notificationService.getTokenUstadzSteam(widget.ustadzId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return MyButton(context, detail, () {});
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return MyButton(context, detail, () {});
              }
              final tokens = snapshot.data!;
              return MyButton(
                context,
                detail,
                () async {
                  for (var tokenMap in tokens) {
                    final token = tokenMap['token'];
                    try {
                      NotificationSend().send(
                        tokenMobile: token,
                        judul: 'Chat dari ${detail!.email}',
                        body: _messageController.text,
                        to: 'ustadz',
                        emailUstadz: widget.email,
                        idUstadz: widget.ustadzId,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Kamu berhasil Send Notification"),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Gagal Send Notification"),
                        ),
                      );
                    }
                  }
                },
              );
            },
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
