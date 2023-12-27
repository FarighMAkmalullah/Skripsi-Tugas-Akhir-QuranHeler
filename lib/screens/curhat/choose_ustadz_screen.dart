import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/curhat/ustadz_view_model.dart';
import 'package:quranhealer/screens/curhat/widget/uztads_card.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/post/all_post_screen.dart';

class ChooseUstadzScreen extends StatefulWidget {
  const ChooseUstadzScreen({super.key});

  @override
  State<ChooseUstadzScreen> createState() => _ChooseUstadzScreenState();
}

class _ChooseUstadzScreenState extends State<ChooseUstadzScreen> {
  late Future detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<UstadzViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getUstadzDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UstadzViewModel>(builder: (context, provider, _) {
      return FutureBuilder(
          future: detailDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: Color(0xFF0E6927)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 28,
                                    height: 23,
                                    child: Image.asset("assets/logo/logo.png"),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'CURHAT USTADZ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 28,
                                height: 23,
                                child: Image.asset(
                                    "assets/icons/dashboard/notification.png"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 25, 16, 16),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AllPostScreen(),
                                        ));
                                  },
                                  child: const Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Lihat Seluruh Post',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          Icon(Icons.chevron_right)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Divider(
                                        color: Color(0xFF8B8A8A),
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText:
                                            'Cari Ustadz Atau Spesialisasi...',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(1)),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                //======================================
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: provider.detailUstadz.length,
                                  itemBuilder: (context, index) {
                                    return UztadsCard(
                                      nama: provider.detailUstadz[index]!.name,
                                      spesialis: provider
                                          .detailUstadz[index]!.spesialisasi,
                                      idUstadz:
                                          provider.detailUstadz[index]!.userId,
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: ErrorScreen(onRefreshPressed: () {
                  provider.getUstadzDetail();
                }),
              );
            } else {
              return Container();
            }
          });
    });
  }
}
