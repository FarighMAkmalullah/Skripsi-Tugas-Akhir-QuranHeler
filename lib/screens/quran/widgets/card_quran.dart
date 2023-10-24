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
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45)),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green[600]),
                    child: Center(
                      child: Text(
                        '${widget.nomor}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.namaLatin),
                      Text(
                        "${widget.arti}, ${widget.tempatTurun}, ${widget.jumlahAyat}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
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
        ],
      ),
    );
  }
}
