import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/quran/detail_quran_view_model.dart';
import 'dart:async';

class DetailSurahScreens extends StatefulWidget {
  final int nomor;
  const DetailSurahScreens({super.key, required this.nomor});

  @override
  State<DetailSurahScreens> createState() => _DetailSurahScreensState();
}

class _DetailSurahScreensState extends State<DetailSurahScreens> {
  late Future<dynamic> detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<DetailSurahViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getSurahDetail(widget.nomor);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailSurahViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      final detail = provider.detailSurah;
      return Scaffold(
        body: FutureBuilder(
          future: detailDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 30, 8, 20),
                        child: Text(
                          'Surah ${detail!.namaLatin}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: detail.ayat.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "${detail.ayat[index].teksArab} ( ${detail.ayat[index].nomorAyat} ) ",
                                style: const TextStyle(fontSize: 25),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(
                                height: 30,
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Tidak ada data');
            }
          },
        ),
      );
    });
  }
}
