import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/hadist/hadist_detail_view_model.dart';

class HadistDetailScreen extends StatefulWidget {
  final String hadist;
  final int nomorAwal;
  final int nomorAkhir;
  const HadistDetailScreen({
    super.key,
    required this.hadist,
    required this.nomorAwal,
    required this.nomorAkhir,
  });

  @override
  State<HadistDetailScreen> createState() => _HadistDetailScreenState();
}

class _HadistDetailScreenState extends State<HadistDetailScreen> {
  late Future<dynamic> detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<DetailHadistViewModel>(context, listen: false);
    try {
      detailDataFuture = detailViewModel.getHadistDetail(
        hadist: widget.hadist,
        nomorAwal: widget.nomorAwal,
        nomorAkhir: widget.nomorAkhir,
      );
      try {
        filteredHadistList = detailViewModel.detailHadist!.hadist;
      } catch (e) {
        return;
      }
    } catch (e) {
      return;
    }
  }

  List filteredHadistList = [];

  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailHadistViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      void filterHadistList(String query) {
        final filteredList = provider.detailHadist!.hadist.where((hadist) {
          return hadist.id.toLowerCase().contains(query.toLowerCase());
        }).toList();

        setState(() {
          filteredHadistList = filteredList;
        });
      }

      final detail = provider.detailHadist;
      return Scaffold(
        appBar: AppBar(
          title: const Text("Hadist"),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            FutureBuilder(
              future: detailDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return ErrorScreen(
                    onRefreshPressed: () {
                      setState(
                        () {
                          detailDataFuture = provider.getHadistDetail(
                            hadist: widget.hadist,
                            nomorAwal: widget.nomorAwal,
                            nomorAkhir: widget.nomorAkhir,
                          );
                        },
                      );
                    },
                  );
                } else if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: const Color(0xFF186D68),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              detail!.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                            Text(
                              "Isi ${detail.available}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              'Dari ${widget.nomorAwal} - ${widget.nomorAkhir}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(16),
                        height: 55,
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            if (value == "") {
                              setState(() {
                                isSearching = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Cari Hadist...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (searchController.text.isEmpty) {
                                    setState(() {
                                      isSearching = false;
                                    });
                                  } else {
                                    setState(() {
                                      isSearching = true;
                                    });
                                    filterHadistList(searchController.text);
                                  }
                                },
                                icon: const Icon(
                                  Icons.search,
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(left: 10)),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF9A9090,
                          ).withOpacity(0.08),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: isSearching
                              ? filteredHadistList.length
                              : detail.hadist.length,
                          itemBuilder: (context, index) {
                            var data = isSearching
                                ? filteredHadistList[index]
                                : detail.hadist[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: index == 0
                                      ? const EdgeInsets.only(
                                          bottom: 8, top: 16)
                                      : const EdgeInsets.symmetric(vertical: 8),
                                  child: RichText(
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(
                                      children: <InlineSpan>[
                                        TextSpan(
                                          text: "${data.arab}  ",
                                          style: const TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 35,
                                                height: 35,
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.green.shade300,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 35,
                                                height: 35,
                                                child: Center(
                                                  child: Text(
                                                    "${data.number}",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(data.id),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(
                                  height: 1,
                                  color: Color(0xFF8B8A8A),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return ErrorScreen(
                    onRefreshPressed: () {
                      setState(
                        () {
                          detailDataFuture = provider.getHadistDetail(
                            hadist: widget.hadist,
                            nomorAwal: widget.nomorAwal,
                            nomorAkhir: widget.nomorAkhir,
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
