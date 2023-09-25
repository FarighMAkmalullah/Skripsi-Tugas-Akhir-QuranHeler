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
              return ListView.builder(
                itemCount: quran.quranlist.length,
                itemBuilder: (context, index) {
                  var data = quran.quranlist[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text('${data.nomor}'),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.namaLatin),
                                Text(
                                    "${data.arti},${data.tempatTurun}, ${data.jumlahAyat}")
                              ],
                            )
                          ],
                        ),
                        Text('${data.nama}')
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    });
  }
}
