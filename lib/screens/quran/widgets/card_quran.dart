import 'package:flutter/material.dart';

class CardQuran extends StatefulWidget {
  final int nomor;
  final String namaLatin;
  final String arti;
  final String tempatTurun;
  final int jumlahAyat;
  final String nama;
  const CardQuran({
    super.key,
    required this.nomor,
    required this.namaLatin,
    required this.arti,
    required this.tempatTurun,
    required this.jumlahAyat,
    required this.nama,
  });

  @override
  State<CardQuran> createState() => _CardQuranState();
}

class _CardQuranState extends State<CardQuran> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: Image.asset('assets/icons/quran/ayat-icon.png'),
                    ),
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.green[600],
                      ),
                      child: Center(
                        child: Text(
                          '${widget.nomor}',
                          // style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.namaLatin),
                    Text(
                      "${widget.arti}, ${widget.jumlahAyat} Ayat",
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    )
                  ],
                )
              ],
            ),
            Text(
              widget.nama,
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
        const SizedBox(
          height: 7,
        ),
        const Divider(
          color: Color(0xFF8B8A8A),
        )
      ],
    );
  }
}
