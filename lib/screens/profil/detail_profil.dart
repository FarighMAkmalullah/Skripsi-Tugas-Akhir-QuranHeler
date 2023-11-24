import 'package:flutter/material.dart';

class DetailProfil extends StatefulWidget {
  const DetailProfil({super.key});

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profil Saya"),
          backgroundColor: const Color(0xFF0E6927),
          elevation: 0,
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF0E6927),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                ),
                const SizedBox(
                  height: 170,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 120,
                          width: 120,
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFD9DCE1),
                            radius: 100,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFD9DCE1),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama Lengkap'),
                  Text('Nama Lengkap Pengguna'),
                  Text('Email'),
                  Text('Email Pengguna'),
                  Text('Gender'),
                  Text('Gender Pengguna'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
