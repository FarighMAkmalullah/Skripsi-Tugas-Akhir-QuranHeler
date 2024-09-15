import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quranhealer/screens/post/ustsdz_post_screen.dart';

class UztadsCard extends StatefulWidget {
  final String nama;
  final String spesialis;
  final int idUstadz;
  const UztadsCard({
    super.key,
    required this.nama,
    required this.spesialis,
    required this.idUstadz,
  });

  @override
  State<UztadsCard> createState() => _UztadsCardState();
}

class _UztadsCardState extends State<UztadsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.asset(
                        "assets/images/chat/chat-account-ustadz.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.nama,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.spesialis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFA7711F),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF486AE1),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UstadzPostScreen(
                            ustadzName: widget.nama,
                            spesialisasi: widget.spesialis,
                            idUstadz: widget.idUstadz,
                          ),
                        ),
                      );
                    },
                    child: const Text('Mulai Post'))
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          // const Divider(
          //   color: Color(0xFF8B8A8A),
          //   height: 1,
          // ),
        ],
      ),
    );
  }
}
