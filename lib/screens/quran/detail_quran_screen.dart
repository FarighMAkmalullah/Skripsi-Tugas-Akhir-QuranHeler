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
  final List quran;
  const DetailSurahScreens({
    super.key,
    required this.nomor,
    required this.arti,
    required this.jumlahAyat,
    required this.namaLatin,
    required this.tempatTurun,
    required this.quran,
  });

  @override
  State<DetailSurahScreens> createState() => _DetailSurahScreensState();
}

class _DetailSurahScreensState extends State<DetailSurahScreens>
    with SingleTickerProviderStateMixin {
  var bismillah = true;
  bool searchAyat = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Future<dynamic> detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<DetailSurahViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getSurahDetail(widget.nomor);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      searchAyat = !searchAyat;
      if (searchAyat) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
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
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailSurahScreens(
                                              nomor: detail!
                                                  .suratSebelumnya!.nomor,
                                              arti: widget
                                                  .quran[detail.suratSebelumnya!
                                                          .nomor -
                                                      1]
                                                  .arti,
                                              jumlahAyat: widget
                                                  .quran[detail.suratSebelumnya!
                                                          .nomor -
                                                      1]
                                                  .jumlahAyat,
                                              namaLatin: detail
                                                  .suratSebelumnya!.namaLatin,
                                              tempatTurun: widget
                                                  .quran[detail.suratSebelumnya!
                                                          .nomor -
                                                      1]
                                                  .tempatTurun,
                                              quran: widget.quran),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: detail?.suratSebelumnya == null
                                            ? const Color(0xFFB8C2B8)
                                            : const Color(0xFF0E6927),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: detail?.suratSebelumnya == null
                                          ? const SizedBox(
                                              child: Icon(
                                                Icons.block,
                                                color: Color(0xFFB8C2B8),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  Icons.chevron_left,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "${detail!.suratSebelumnya?.namaLatin}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailSurahScreens(
                                              nomor: detail!
                                                  .suratSelanjutnya!.nomor,
                                              arti: widget
                                                  .quran[detail
                                                          .suratSelanjutnya!
                                                          .nomor -
                                                      1]
                                                  .arti,
                                              jumlahAyat: widget
                                                  .quran[detail
                                                          .suratSelanjutnya!
                                                          .nomor -
                                                      1]
                                                  .jumlahAyat,
                                              namaLatin: detail
                                                  .suratSelanjutnya!.namaLatin,
                                              tempatTurun: widget
                                                  .quran[detail
                                                          .suratSelanjutnya!
                                                          .nomor -
                                                      1]
                                                  .tempatTurun,
                                              quran: widget.quran),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: detail?.suratSelanjutnya == null
                                            ? const Color(0xFFB8C2B8)
                                            : const Color(0xFF0E6927),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: detail?.suratSelanjutnya == null
                                          ? const SizedBox(
                                              child: Icon(
                                                Icons.block,
                                                color: Color(0xFFB8C2B8),
                                              ),
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${detail!.suratSelanjutnya?.namaLatin}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Icon(
                                                  Icons.chevron_right,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: _toggleSearch,
                                  child: const Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                                visible: searchAyat,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: Column(
                                    children: [
                                      const TextField(),
                                      FractionallySizedBox(
                                        widthFactor: 1.0,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Cari Ayat')),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 25,
                            ),
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
