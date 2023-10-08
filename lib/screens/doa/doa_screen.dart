import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/doa/doa_view_model.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  late Future<void> doaDataViewModel;
  @override
  void initState() {
    final quranViewModel = Provider.of<DoaViewModel>(context, listen: false);
    doaDataViewModel = quranViewModel.fetchDoaViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DoaViewModel>(builder: (
      context,
      doa,
      _,
    ) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Doa Pilihan'),
        ),
        body: FutureBuilder<void>(
            future: doaDataViewModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: doa.doalist.length,
                      itemBuilder: (context, index) {
                        var data = doa.doalist[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.all(8),
                          child: Text('${data.title}'),
                        );
                      }),
                );
              }
            }),
      );
    });
  }
}
