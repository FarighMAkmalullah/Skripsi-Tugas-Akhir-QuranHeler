import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/adzan/adzan_view_model.dart';
import 'package:quranhealer/screens/adzan/detail_adzan_screen.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/dashboard/dashboard_view_model.dart';
import 'package:quranhealer/screens/error/error_screen.dart';

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
    return Consumer2<AdzanViewModel, DashboarViewModel>(
      builder: (
        context,
        adzan,
        dashboard,
        _,
      ) {
        void filterAdzanList(String query) {
          final filteredList = adzan.adzanlist.where((adzan) {
            return adzan.lokasi.toLowerCase().contains(query.toLowerCase());
          }).toList();

          setState(() {
            filteredAdzanList = filteredList;
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Cari Kota Adzan',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.location_city))
            ],
          ),
          body: SafeArea(
            child: FutureBuilder<void>(
              future: adzanDataViewModel,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return ErrorScreen(
                    onRefreshPressed: () {
                      setState(
                        () {
                          adzanDataViewModel = adzan.fetchAdzanViewModel();
                        },
                      );
                    },
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              isSearching = true;
                            });
                            filterAdzanList(value);
                          },
                          decoration: InputDecoration(
                              hintText: 'Cari Kota...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
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
                        const SizedBox(
                          height: 8,
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
                                  dashboard.setKotaAdzan(data.lokasi, data.id);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const BottomBar(dashboardIndex: 2),
                                    ),
                                    (route) => false,
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.lokasi,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Icon(Icons.location_on)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 9,
                                      ),
                                      const Divider(
                                        color: Color(0xFF8B8A8A),
                                        height: 1,
                                      )
                                    ],
                                  ),
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
          ),
        );
      },
    );
  }
}
