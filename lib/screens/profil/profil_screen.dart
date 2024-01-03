// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/profil/detail_profil.dart';
import 'package:quranhealer/screens/profil/edit_password_screen.dart';
import 'package:quranhealer/screens/profil/edit_profil_screen.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
import 'package:quranhealer/screens/profil/widget/header_profil_card.dart';
import 'package:quranhealer/screens/terms_and_privacy_policy/privacy_policy.dart';
import 'package:quranhealer/screens/terms_and_privacy_policy/terms_screen.dart';
import 'package:quranhealer/services/logout/logout_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  late Future detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<ProfilViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getProfilDetail();
  }

  bool isLoading = false;

  _openWhatsApp() async {
    // Ganti nomor berikut dengan nomor yang ingin Anda hubungi
    String phoneNumber = "6281234567890";

    // Ganti pesan berikut sesuai kebutuhan
    String message = "Halo, apa kabar?";

    // Format URL dengan menggunakan URI Scheme WhatsApp
    String url =
        "https://wa.me/$phoneNumber/?text=${Uri.encodeQueryComponent(message)}";

    // Buka URL menggunakan package url_launcher
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Tidak dapat membuka WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      final detail = provider.detailUser;
      // print(detail);
      return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
            future: detailDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return SafeArea(
                  child: ListView(
                    children: [
                      HeaderProfilCard(
                        namaLengkap: detail!.name,
                        email: detail.email,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFD9DCE1),
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //====================================================
                            const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text('Akun'),
                            ),
                            const Divider(
                              color: Colors.white,
                              height: 0,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 23,
                                horizontal: 15,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailProfil(
                                            email: detail.email,
                                            namaLengkap: detail.name,
                                            gender: detail.gender,
                                          ),
                                        )),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Profil Saya'),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfilScreen(
                                              namaLengkap: detail.name,
                                              email: detail.email,
                                              gender: detail.gender,
                                            ),
                                          ));
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Edit Akun'),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditPasswordScreen(),
                                          ));
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Edit Password'),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              height: 0,
                              thickness: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(15),
                              child: Text('Information'),
                            ),
                            const Divider(
                              color: Colors.white,
                              height: 0,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 23,
                                horizontal: 15,
                              ),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyPolicyScreen(),
                                          ));
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Privacy Policy'),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Mohon Maaf'),
                                            content: const Text(
                                                'Fitur ini masih dalam pengembangan'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const TermsScreen(),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Terms and Condition'),
                                          Icon(
                                            Icons.chevron_right,
                                            size: 17,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Mohon Maaf'),
                                            content: const Text(
                                                'Fitur ini masih dalam pengembangan'),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Close'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('About Us'),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.white,
                              height: 0,
                              thickness: 5,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                var res = await LogoutService().logout();
                                if (res.containsKey('result') && res != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  const snackBar = SnackBar(
                                    content: Text('Logout Berhasil'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  removeToken();
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/', (route) => false);
                                } else if (res.containsKey('error') &&
                                    res != null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  const snackBar = SnackBar(
                                    content:
                                        Text('Logout Gagal Silahkan COba Lagi'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: isLoading
                                    ? const CircularProgressIndicator()
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Logout'),
                                          Icon(
                                            Icons.logout,
                                            size: 17,
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: ErrorScreen(onRefreshPressed: () {
                    provider.getProfilDetail();
                  }),
                );
              } else {
                return Container();
              }
            }),
      );
    });
  }
}
