import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/quran/detail_quran_screen.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';
import 'package:quranhealer/screens/quran/widgets/card_quran.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late Future<void> quranDataViewModel;
  @override
  void initState() {
    final quranViewModel = Provider.of<QuranViewModel>(context, listen: false);
    quranDataViewModel = quranViewModel.fetchQuranViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranViewModel>(
      builder: (context, quran, child) {
        return FutureBuilder<void>(
          future: quranDataViewModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: quran.quranlist.length,
                  itemBuilder: (context, index) {
                    var data = quran.quranlist[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailSurahScreens(
                              nomor: data.nomor,
                              arti: data.arti,
                              jumlahAyat: data.jumlahAyat,
                              namaLatin: data.namaLatin,
                              tempatTurun: data.tempatTurun,
                            ),
                          ),
                        );
                      },
                      child: CardQuran(
                        nomor: data.nomor,
                        namaLatin: data.namaLatin,
                        arti: data.arti,
                        tempatTurun: data.tempatTurun,
                        jumlahAyat: data.jumlahAyat,
                        nama: data.nama,
                      ),
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
