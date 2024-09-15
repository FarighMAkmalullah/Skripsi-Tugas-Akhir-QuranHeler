import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quranhealer/screens/ustadz/personal_ustadz_chat_screen.dart';
import 'package:quranhealer/services/ustadz_chat/ustadz_chat_service.dart';

class ChatUstadzScreen extends StatefulWidget {
  final String email;
  final int idUser;
  const ChatUstadzScreen({
    super.key,
    required this.email,
    required this.idUser,
  });

  @override
  State<ChatUstadzScreen> createState() => _ChatUstadzScreenState();
}

class _ChatUstadzScreenState extends State<ChatUstadzScreen> {
  final ChatUstadzService _chatService = ChatUstadzService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF186D68),
        title: const Text('Chat Ustadz'),
        foregroundColor: Colors.white,
      ),
      body: _buildUserList(),
    );
  }

  // membuat build list user kecuali yang login
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(widget.email, widget.idUser),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error.."),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != widget.email) {
      return UserTileWidget(
        onTap: () {
          _chatService.readNotfUstadz(
            widget.email,
            userData["email"],
            widget.idUser,
            userData["user_id"],
          );
          _chatService.readNotfUstadzAll(
            widget.email,
            userData["notfustadz"],
            widget.idUser,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalUstadzChatScreen(
                email: userData["email"],
                name: userData["name"],
                genderR: userData['gender'],
                spesialisasi: 'User',
                userId: userData["user_id"],
              ),
            ),
          );
        },
        email: userData["email"],
        name: userData["name"],
        spesialis: 'User',
        gender: userData["gender"],
        notifustadz: userData["notfustadz"],
        timestamp: userData["timestamp"],
      );
    } else {
      return Container();
    }
  }
}

class UserTileWidget extends StatelessWidget {
  final String email;
  final String name;
  final String spesialis;
  final String gender;
  final int notifustadz;
  final Timestamp timestamp;
  final void Function()? onTap;
  const UserTileWidget({
    super.key,
    required this.email,
    required this.name,
    required this.spesialis,
    this.onTap,
    required this.gender,
    required this.notifustadz,
    required this.timestamp,
  });

  String getTanggal(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      child: gender == 'L'
                          ? Image.asset(
                              "assets/images/chat/chat-account-user.png",
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              "assets/images/chat/chat-account-userp.png",
                              fit: BoxFit.contain,
                            ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            spesialis,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B8A8A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      getTanggal(timestamp),
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Visibility(
                      visible: notifustadz != 0,
                      child: SizedBox(
                        height: 30,
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            "$notifustadz",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color.fromARGB(255, 199, 199, 199),
          ),
        ],
      ),
    );
  }
}
