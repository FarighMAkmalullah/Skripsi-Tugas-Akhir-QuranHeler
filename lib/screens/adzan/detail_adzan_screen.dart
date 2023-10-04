import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailAdzan extends StatefulWidget {
  final String id;
  final String nama;
  const DetailAdzan({super.key, required this.id, required this.nama});

  @override
  State<DetailAdzan> createState() => _DetailAdzanState();
}

class _DetailAdzanState extends State<DetailAdzan> {
  @override
  void initState() {
    super.initState();
    // ignore: unused_local_variable
    String formattedTime = DateFormat.Hms().format(DateTime.now());
  }

  Stream<DateTime> clockStream() {
    // ignore: prefer_const_constructors
    return Stream.periodic(Duration(seconds: 1), (i) => DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kota: ${widget.nama}',
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
                    child: const Text(
                      'Subuh : 04:00',
                      textAlign: TextAlign.center,
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
                    child: const Text(
                      'Dzuhur : 12:00',
                      textAlign: TextAlign.center,
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
                    child: const Text(
                      'Ashar : 15:00',
                      textAlign: TextAlign.center,
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
                    child: const Text(
                      'Maghrib : 18:00',
                      textAlign: TextAlign.center,
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
                    child: const Text(
                      'Isya : 19:00',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
