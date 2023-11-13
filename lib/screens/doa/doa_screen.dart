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
    return Consumer<DoaViewModel>(
      builder: (
        context,
        doa,
        _,
      ) {
        return FutureBuilder<void>(
          future: doaDataViewModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: doa.doalist.length,
                        itemBuilder: (context, index) {
                          var data = doa.doalist[index];
                          return Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  data.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.arabic,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  data.translation,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
