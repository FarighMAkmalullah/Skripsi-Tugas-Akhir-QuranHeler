import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/doa/doa_view_model.dart';
import 'package:quranhealer/screens/doa/widget/doa_widget.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen>
    with AutomaticKeepAliveClientMixin<DoaScreen> {
  late Future<void> doaDataViewModel;

  @override
  void initState() {
    final quranViewModel = Provider.of<DoaViewModel>(context, listen: false);
    doaDataViewModel = quranViewModel.fetchDoaViewModel();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 20,
                        ),
                        margin: const EdgeInsets.all(8),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C5138),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daftar Doa-Doa',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Pilihan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              child: Image.asset(
                                "assets/icons/pray/praying.png",
                                height: 44,
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: doa.doalist.length,
                        itemBuilder: (context, index) {
                          var data = doa.doalist[index];

                          // bool doaDetail = true;
                          return DoaWidget(
                            title: data.title,
                            arabic: data.arabic,
                            translation: data.translation,
                            latin: data.latin,
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
