import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/doa/doa_view_model.dart';
import 'package:quranhealer/screens/doa/widget/doa_widget.dart';
import 'package:quranhealer/screens/error/error_screen.dart';

class DoaNewScreen extends StatefulWidget {
  const DoaNewScreen({super.key});

  @override
  State<DoaNewScreen> createState() => _DoaNewScreenState();
}

class _DoaNewScreenState extends State<DoaNewScreen>
    with AutomaticKeepAliveClientMixin<DoaNewScreen> {
  late Future<void> doaDataViewModel;

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    final doaViewModel = Provider.of<DoaViewModel>(context, listen: false);
    doaDataViewModel = doaViewModel.fetchDoaViewModel();

    filteredQuranList = doaViewModel.doalist;
    super.initState();
  }

  List filteredQuranList = [];

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
        void filterQuranList(String query) {
          final filteredList = doa.doalist.where((surah) {
            return surah.title.toLowerCase().contains(query.toLowerCase());
          }).toList();

          setState(() {
            filteredQuranList = filteredList;
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Doa Pilihan'),
            centerTitle: true,
            backgroundColor: const Color(0xFF0E6969),
            foregroundColor: Colors.white,
          ),
          body: FutureBuilder<void>(
            future: doaDataViewModel,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return ErrorScreen(
                  onRefreshPressed: () {
                    setState(
                      () {
                        doaDataViewModel = doa.fetchDoaViewModel();
                      },
                    );
                  },
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 20,
                          ),
                          margin: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xFF0E6969).withOpacity(0.9),
                                const Color(0xFF0E6969),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                hintText: 'Cari Doa...',
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
                              : doa.doalist.length,
                          itemBuilder: (context, index) {
                            var data = isSearching
                                ? filteredQuranList[index]
                                : doa.doalist[index];

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
          ),
        );
      },
    );
  }
}
