import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:quranhealer/screens/adzan/detail_adzan_view_model.dart';

class DetailAdzan extends StatefulWidget {
  final String id;
  final String nama;
  const DetailAdzan({super.key, required this.id, required this.nama});

  @override
  State<DetailAdzan> createState() => _DetailAdzanState();
}

class _DetailAdzanState extends State<DetailAdzan> {
  late Future<dynamic> detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailAdzanViewModel =
        Provider.of<DetailAdzanViewModel>(context, listen: false);
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    detailDataFuture =
        detailAdzanViewModel.getAdzanDetail(widget.id, currentDate);

    // ignore: unused_local_variable
    String formattedTime = DateFormat.Hms().format(DateTime.now());
  }

  Stream<DateTime> clockStream() {
    // ignore: prefer_const_constructors
    return Stream.periodic(Duration(seconds: 1), (i) => DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailAdzanViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      final detail = provider.detailAdzan;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal Shalat'),
          centerTitle: true,
        ),
        body: StreamBuilder<DateTime>(
          stream: clockStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final formattedTime = DateFormat.Hms().format(snapshot.data!);
              return FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Kota: ${widget.nama}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            '${detail?.tanggal}',
                            style: const TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Jam saat ini: $formattedTime',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(6),
                            child: Text(
                              'Subuh : ${detail?.subuh}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(6),
                            child: Text(
                              'Dhuha : ${detail?.dhuha}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(6),
                            child: Text(
                              'Dzuhur : ${detail?.dzuhur}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(6),
                            child: Text(
                              'Ashar : ${detail?.ashar}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(6),
                            child: Text(
                              'Maghrib : ${detail?.maghrib}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(6),
                            child: Text(
                              'Isya : ${detail?.isya}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Text('Tidak ada data');
                  }
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    });
  }
}
