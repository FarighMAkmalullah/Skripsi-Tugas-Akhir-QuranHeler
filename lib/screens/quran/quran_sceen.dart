import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/quran/detail_quran_screen.dart';
import 'package:quranhealer/screens/quran/quran_new_screen.dart';
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

  String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');
    List<String> capitalizedWords = words.map((word) {
      if (word.isNotEmpty) {
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      } else {
        return word;
      }
    }).toList();
    return capitalizedWords.join(' ');
  }

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<QuranViewModel>(
      builder: (context, quran, child) {
        void filterQuranList(String query) {
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
              return ErrorScreen(
                onRefreshPressed: () {
                  setState(
                    () {
                      quranDataViewModel = quran.fetchQuranViewModel();
                    },
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QuranNewScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 123, 151, 151),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Lihat di halaman baru",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 123, 151, 151),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        height: 55,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              isSearching = true;
                            });
                            filterQuranList(value);
                          },
                          decoration: InputDecoration(
                              hintText: 'Cari Surah...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
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
                                    tempatTurun:
                                        capitalizeEachWord(data.tempatTurun),
                                    quran: quran.quranlist,
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
              return const Center();
            }
          },
        );
      },
    );
  }
}
