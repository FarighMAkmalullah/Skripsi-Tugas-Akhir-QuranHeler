import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/adzan/adzan_view_model.dart';
import 'package:quranhealer/screens/adzan/detail_adzan_screen.dart';

class AdzanScreen extends StatefulWidget {
  const AdzanScreen({super.key});

  @override
  State<AdzanScreen> createState() => _AdzanScreenState();
}

class _AdzanScreenState extends State<AdzanScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  late Future<void> adzanDataViewModel;

  @override
  void initState() {
    final adzanViewModel = Provider.of<AdzanViewModel>(context, listen: false);
    adzanDataViewModel = adzanViewModel.fetchAdzanViewModel();
    super.initState();
    Provider.of<AdzanViewModel>(context, listen: false).fetchAdzanViewModel();
    filteredAdzanList = adzanViewModel.adzanlist;
  }

  List filteredAdzanList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<AdzanViewModel>(builder: (
      context,
      adzan,
      _,
    ) {
      void filterAdzanList(String query) {
        final filteredList = adzan.adzanlist.where((adzan) {
          return adzan.nama.toLowerCase().contains(query.toLowerCase());
        }).toList();

        setState(() {
          filteredAdzanList = filteredList;
        });
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('List Kota Adzan'),
          centerTitle: true,
        ),
        body: FutureBuilder<void>(
          future: adzanDataViewModel,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            isSearching = true;
                          });
                          filterAdzanList(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Cari Kota...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: isSearching
                            ? filteredAdzanList.length
                            : adzan.adzanlist.length,
                        itemBuilder: (context, index) {
                          var data = isSearching
                              ? filteredAdzanList[index]
                              : adzan.adzanlist[index];

                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailAdzan(id: data.id, nama: data.nama),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(data.nama),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      );
    });
  }
}
