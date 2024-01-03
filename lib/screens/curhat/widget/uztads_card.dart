import 'package:flutter/material.dart';
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
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(
                    height: 50,
                    width: 50,
                    child: CircleAvatar(
                      backgroundColor: Color(0xFFD9DCE1),
                      radius: 100,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.nama,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.spesialis,
                        style: const TextStyle(
                          color: Color(0xFFA7711F),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
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
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Color(0xFF8B8A8A),
            height: 1,
          ),
        ],
      ),
    );
  }
}
