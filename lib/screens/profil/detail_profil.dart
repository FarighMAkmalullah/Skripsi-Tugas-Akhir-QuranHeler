import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/core/init/const/access_firebase_token.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';

class DetailProfil extends StatefulWidget {
  final String namaLengkap;
  final String email;
  final String gender;
  final String role;
  const DetailProfil({
    super.key,
    required this.namaLengkap,
    required this.email,
    required this.gender,
    required this.role,
  });

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  late Future detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<ProfilViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getProfilDetail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profil Saya",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF186D68),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF186D68),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                ),
                SizedBox(
                  // height: 170,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 10,
                              color: Colors.white,
                            ),
                          ),
                          height: 150,
                          width: 150,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nama Lengkap'),
                  Text(
                    widget.namaLengkap,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Email'),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('Gender'),
                  Text(
                    widget.gender == "L" ? "Laki-laki" : "Perempuan",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
