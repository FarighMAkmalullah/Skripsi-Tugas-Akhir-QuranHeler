// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/curhat/personal_chat_screen.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
// import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:quranhealer/services/chat/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Ustadz'),
        centerTitle: true,
        backgroundColor: const Color(0xFF186D68),
        foregroundColor: Colors.white,
      ),
      // drawer: const MyDrawerWidget(),
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(bottom: 30, top: 10, left: 20, right: 20),
            decoration: const BoxDecoration(
              color: Color(0xFF186D68),
              // borderRadius: BorderRadius.only(
              //   bottomRight: Radius.circular(
              //     20,
              //   ),
              // ),
            ),
            child: const Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      'Chat bareng ustadz pribadi, Kamu bisa curhat apa aja disini...',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                height: 175 / 2,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xFF186D68),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 0),
                  width: MediaQuery.of(context).size.width * (2 / 3),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xFF186D68),
                    border: Border.all(
                      width: 5,
                      color: const Color(0xFFF4F4F4),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 175,
                  child: Image.asset(
                    "assets/images/chat/chat-header.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Ustadz Spesialis',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color.fromARGB(255, 199, 199, 199),
          ),
          _buildUserList(),
        ],
      ),
    );
  }

  // membuat build list user kecuali yang login
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
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
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    return Visibility(
      visible: userData["user_id"] != 68,
      child: UserTileWidget(
        email: userData["email"],
        name: userData["name"],
        spesialis: userData["spesialis"],
        onTap: () {},
        userId: userData["user_id"],
      ),
    );
  }
}

class UserTileWidget extends StatelessWidget {
  final String email;
  final String name;
  final String spesialis;
  final int userId;
  final void Function()? onTap;
  const UserTileWidget({
    super.key,
    required this.email,
    required this.name,
    required this.spesialis,
    required this.userId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ChatService chatService = ChatService();
    return Consumer<ProfilViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      final detail = provider.detailUser;
      return GestureDetector(
        onTap: () async {
          bool userExists = await chatService.doesUserExistInChatRoomUstadz(
              userId, detail.user_id);
          if (userExists) {
            chatService.readNotfUser(
              userId,
              detail.user_id,
            );
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalChatScreen(
                email: email,
                name: name,
                spesialisasi: spesialis,
                ustadzId: userId,
              ),
            ),
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: 50,
                            child: Image.asset(
                              "assets/images/chat/chat-account-ustadz.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: StreamBuilder(
                              stream: chatService.getNotfUser(
                                userId,
                                detail!.user_id,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                }
                                if (snapshot.hasError) {
                                  return Container();
                                }
                                if (!snapshot.hasData ||
                                    !snapshot.data!.exists) {
                                  return Container();
                                }
                                int notfustadz =
                                    snapshot.data!.get('notfuser') ?? 0;
                                return Visibility(
                                  visible: notfustadz != 0,
                                  child: const Icon(
                                    Icons.chat,
                                    color: Colors.blue,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
                              "Spesialis $spesialis",
                              overflow: TextOverflow.clip,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF8B8A8A),
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "5.0",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF8B8A8A),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: const Text(
                          'Chat',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      StreamBuilder(
                        stream: chatService.getNotfUser(
                          userId,
                          detail.user_id,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }
                          if (snapshot.hasError) {
                            return Container();
                          }
                          if (!snapshot.hasData || !snapshot.data!.exists) {
                            return Container();
                          }
                          int notfustadz = snapshot.data!.get('notfuser') ?? 0;
                          return Visibility(
                            visible: notfustadz != 0,
                            child: SizedBox(
                              height: 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.orange,
                                child: Text(
                                  "$notfustadz",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          );
                        },
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
    });
  }
}
