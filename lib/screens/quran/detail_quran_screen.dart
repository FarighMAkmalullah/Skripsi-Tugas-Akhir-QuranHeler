import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/quran/detail_quran_view_model.dart';
import 'dart:async';

class DetailSurahScreens extends StatefulWidget {
  final int nomor;
  final String namaLatin;
  final String arti;
  final int jumlahAyat;
  final String tempatTurun;
  const DetailSurahScreens({
    super.key,
    required this.nomor,
    required this.arti,
    required this.jumlahAyat,
    required this.namaLatin,
    required this.tempatTurun,
  });

  @override
  State<DetailSurahScreens> createState() => _DetailSurahScreensState();
}

class _DetailSurahScreensState extends State<DetailSurahScreens> {
  var bismillah = true;
  late Future<dynamic> detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<DetailSurahViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getSurahDetail(widget.nomor);
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailSurahViewModel>(
      builder: (
        context,
        provider,
        _,
      ) {
        final detail = provider.detailSurah;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.namaLatin,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E6927),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '${widget.nomor}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                      Text(
                        widget.namaLatin,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        widget.arti,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        '${widget.tempatTurun}, ${widget.jumlahAyat} Ayat',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 8),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF9A9090,
                    ).withOpacity(0.18),
                  ),
                  child: FutureBuilder(
                    future: detailDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData) {
                        return Column(
                          children: [
                            bismillah
                                ? const Column(
                                    children: [
                                      Text(
                                        "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ",
                                        style: TextStyle(
                                          fontSize: 25,
                                          color: Color(0xFFA7711F),
                                        ),
                                      ),
                                      Text(
                                        "bismillāhir-raḥmānir-raḥīm(i).",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFFA7711F),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "Dengan nama Allah Yang Maha Pengasih, Maha Penyayang.",
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )
                                : const Text(""),
                            const SizedBox(
                              height: 30,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: detail?.ayat.length,
                              itemBuilder: (context, index) {
                                // if (detail?.ayat[0].teksArab ==
                                //     "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ") {
                                //   setState(() {
                                //     bismillah = false;
                                //   });
                                // }
                                return detail?.ayat[index].teksArab !=
                                        "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ"
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                            text: TextSpan(
                                              children: <InlineSpan>[
                                                TextSpan(
                                                  text:
                                                      "${detail?.ayat[index].teksArab}  ",
                                                  style: const TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                WidgetSpan(
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        width: 35,
                                                        height: 35,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xFF0E6927),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 35,
                                                        height: 35,
                                                        child: Center(
                                                          child: Text(
                                                            "${detail?.ayat[index].nomorAyat}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.7,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${detail?.ayat[index].teksLatin}",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xFFA7711F)),
                                                    ),
                                                    const SizedBox(
                                                      height: 7,
                                                    ),
                                                    Text(
                                                        "${detail?.ayat[index].teksIndonesia}")
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 8, 6, 8),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Image.asset(
                                                  'assets/icons/quran/play.png',
                                                  height: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const Divider(
                                            height: 1,
                                            color: Color(0xFF8B8A8A),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        );
                      } else {
                        return const Text('Tidak ada data');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
