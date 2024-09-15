import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderProfilCard extends StatefulWidget {
  String namaLengkap;
  String email;
  String gender;
  String role;
  HeaderProfilCard({
    super.key,
    required this.namaLengkap,
    required this.email,
    required this.gender,
    required this.role,
  });

  @override
  State<HeaderProfilCard> createState() => _HeaderProfilCardState();
}

class _HeaderProfilCardState extends State<HeaderProfilCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0E6969).withOpacity(0.9),
            const Color(0xFF0E6969),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Center(
              child: Text(
                'Akun Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: widget.role == 'user'
                      ? widget.gender == 'L'
                          ? Image.asset(
                              "assets/images/chat/chat-account-user.png",
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              "assets/images/chat/chat-account-userp.png",
                              fit: BoxFit.contain,
                            )
                      : Image.asset(
                          "assets/images/chat/chat-account-ustadz.png",
                          fit: BoxFit.contain),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.namaLengkap,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
