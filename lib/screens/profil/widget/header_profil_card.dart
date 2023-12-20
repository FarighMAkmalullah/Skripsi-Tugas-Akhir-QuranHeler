import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderProfilCard extends StatefulWidget {
  String namaLengkap;
  String email;
  HeaderProfilCard({
    super.key,
    required this.namaLengkap,
    required this.email,
  });

  @override
  State<HeaderProfilCard> createState() => _HeaderProfilCardState();
}

class _HeaderProfilCardState extends State<HeaderProfilCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF0E6927),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              'Profil',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  backgroundColor: Color(0xFFD9DCE1),
                  radius: 100,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.namaLengkap,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
