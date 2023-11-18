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

class _QuranScreenState extends State<QuranScreen>
    with AutomaticKeepAliveClientMixin<QuranScreen> {
  late Future<void> quranDataViewModel;
  @override
  void initState() {
    final quranViewModel = Provider.of<QuranViewModel>(context, listen: false);
    quranDataViewModel = quranViewModel.fetchQuranViewModel();

    filteredQuranList = quranViewModel.quranlist;
    super.initState();
  }

  List filteredQuranList = [];

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<QuranViewModel>(
      builder: (context, quran, child) {
        void filterAdzanList(String query) {
          final filteredList = quran.quranlist.where((surah) {
            return surah.namaLatin.toLowerCase().contains(query.toLowerCase());
          }).toList();

          setState(() {
            filteredQuranList = filteredList;
          });
        }

        return FutureBuilder<void>(
          future: quranDataViewModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        height: 55,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              isSearching = true;
                            });
                            filterAdzanList(value);
                          },
                          decoration: InputDecoration(
                              hintText: 'Cari Surah...',
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
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: isSearching
                            ? filteredQuranList.length
                            : quran.quranlist.length,
                        itemBuilder: (context, index) {
                          var data = isSearching
                              ? filteredQuranList[index]
                              : quran.quranlist[index];
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
                    ],
                  ),
                ),
              );
            } else {
              return Center();
            }
          },
        );
      },
    );
  }
}
