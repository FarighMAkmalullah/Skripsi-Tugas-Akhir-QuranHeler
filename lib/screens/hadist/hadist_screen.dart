import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/hadist/hadist_detail_screen.dart';
import 'package:quranhealer/screens/hadist/hadist_new_sceen.dart';
import 'package:quranhealer/screens/hadist/hadist_view_model.dart';

class HadistScreen extends StatefulWidget {
  const HadistScreen({super.key});

  @override
  State<HadistScreen> createState() => _HadistScreenState();
}

class _HadistScreenState extends State<HadistScreen> {
  late Future<void> hadistDataViewModel;

  final HadistViewModel firestoreService = HadistViewModel();

  final formKey = GlobalKey<FormState>();
  final TextEditingController jumAwalController = TextEditingController();
  final TextEditingController jumAkhirController = TextEditingController();

  String validateJum = "";
  @override
  void initState() {
    // final hadistViewModel =
    //     Provider.of<HadistViewModel>(context, listen: false);
    // hadistDataViewModel = hadistViewModel.fetchHadistViewModel();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    jumAwalController.dispose();
    jumAkhirController.dispose();
  }

  Future<dynamic> searchHadist(String book, int jum, String hadist) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          book,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: jumAwalController,
                          validator: (awal) {
                            if (jumAwalController.text.isEmpty) {
                              return 'Masukkan angka yang valid';
                            } else if (int.parse(awal!) < 0) {
                              return 'Masukkan angka 1 - $jum';
                            } else if (int.parse(awal) > jum) {
                              return 'Masukkan angka awal harus lebih kecil dari isi buku';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Dari Nomer',
                            prefixIcon: const Icon(Icons.book),
                            hintText: 'Masukkan Nomer Awal Dari 1 - $jum',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: jumAkhirController,
                          validator: (akhir) {
                            if (jumAkhirController.text.isEmpty) {
                              return 'Masukkan angka yang valid';
                            } else if (int.parse(akhir!) < 0) {
                              return 'Masukkan angka 1 - $jum';
                            } else if (int.parse(akhir) > jum) {
                              return 'Masukkan angka akhir harus lebih kecil dari isi buku';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Sampai Nomer',
                            prefixIcon: const Icon(Icons.book),
                            hintText: 'Masukkan Nomer Akhir Dari 1 - $jum',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: validateJum != "",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            validateJum,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState!.validate()) {
                                if (int.parse(jumAwalController.text) >
                                    int.parse(jumAkhirController.text)) {
                                  setState(() {
                                    validateJum =
                                        "Nomer Awal Harus Lebih Kecil Dari Nomer Akhir";
                                  });
                                } else if (int.parse(jumAkhirController.text) <
                                    int.parse(jumAwalController.text)) {
                                  setState(() {
                                    validateJum =
                                        "Nomer Akhir Harus Lebih Besar Dari Nomer Awal";
                                  });
                                } else {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HadistDetailScreen(
                                        hadist: hadist,
                                        nomorAwal:
                                            int.parse(jumAwalController.text),
                                        nomorAkhir:
                                            int.parse(jumAkhirController.text),
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    validateJum = "";
                                  });
                                }
                              }
                            },
                            child: Text("Cari $book..")),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HadistViewModel>(
      builder: (
        context,
        hadist,
        _,
      ) {
        return StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getNotesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return ErrorScreen(onRefreshPressed: () {
                setState(() {
                  hadistDataViewModel = hadist.fetchHadistViewModel();
                });
                hadist.fetchHadistViewModel();
              });
            } else if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HadistNewScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              width: 3,
                              color: Color.fromARGB(255, 123, 151, 151),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Lihat di halaman baru",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 123, 151, 151),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 20,
                          ),
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
                              const Text(
                                'Daftar Hadist',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                child: Image.asset(
                                  "assets/icons/hadist/book.png",
                                  height: 44,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          itemCount: notesList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            // get each individual doc

                            DocumentSnapshot document = notesList[index];

                            // get note from each doc

                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                searchHadist(
                                  data['name'],
                                  data['available'],
                                  data['id'],
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 16,
                                ),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: const Border(
                                    left: BorderSide(
                                      width: 3,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.book,
                                          color:
                                              Color.fromARGB(255, 158, 95, 0),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          data['name'],
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // const Text(
                                        //   "Isi",
                                        //   style: TextStyle(fontSize: 13),
                                        // ),
                                        Text(
                                          "${data['available']}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return ErrorScreen(onRefreshPressed: () {
                setState(() {
                  hadistDataViewModel = hadist.fetchHadistViewModel();
                });
                hadist.fetchHadistViewModel();
              });
            }
          },
        );
      },
    );
  }
}
