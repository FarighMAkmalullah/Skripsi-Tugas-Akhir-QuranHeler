import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';

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
    return Consumer<QuranViewModel>(builder: (context, quran, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quran in QuranHealer'),
          centerTitle: true,
        ),
        body: FutureBuilder<void>(
          future: quranDataViewModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: quran.quranlist.length,
                  itemBuilder: (context, index) {
                    var data = quran.quranlist[index];
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
                                        '${data.nomor}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.namaLatin),
                                      Text(
                                        "${data.arti}, ${data.tempatTurun}, ${data.jumlahAyat}",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                data.nama,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      );
    });
  }
}
