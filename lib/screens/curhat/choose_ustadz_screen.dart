import 'package:flutter/material.dart';
import 'package:quranhealer/screens/curhat/widget/uztads_card.dart';

class ChooseUstadzScreen extends StatefulWidget {
  const ChooseUstadzScreen({super.key});

  @override
  State<ChooseUstadzScreen> createState() => _ChooseUstadzScreenState();
}

class _ChooseUstadzScreenState extends State<ChooseUstadzScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(color: Color(0xFF0E6927)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 28,
                          height: 23,
                          child: Image.asset("assets/logo/logo.png"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'CURHAT UZTADS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 28,
                      height: 23,
                      child: Image.asset(
                          "assets/icons/dashboard/notification.png"),
                    ),
                  ],
                ),
              ),
            ),
            ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lihat Seluruh Post',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.chevron_right)
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Divider(
                        color: Color(0xFF8B8A8A),
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Cari Uztads Atau Spesialisasi...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              contentPadding: const EdgeInsets.all(1)),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      //======================================
                      const UztadsCard(
                        nama: 'Uztads Toha',
                        spesialis: 'Spesialis Quran',
                      ),
                      const UztadsCard(
                        nama: 'Uztads Suparyanto',
                        spesialis: 'Spesialis Hadist',
                      ),
                      const UztadsCard(
                        nama: 'Uztads Khalid',
                        spesialis: 'Spesialis Sunnah',
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
