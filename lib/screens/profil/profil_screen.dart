import 'package:flutter/material.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/screens/profil/detail_profil.dart';
import 'package:quranhealer/screens/profil/edit_profil_screen.dart';
import 'package:quranhealer/screens/profil/widget/header_profil_card.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            const HeaderProfilCard(),
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
                                builder: (context) => const DetailProfil(),
                              )),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      const EditProfilScreen(),
                                ));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delete Akun'),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Help Centre'),
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
                    onTap: () {
                      removeToken();

                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
    );
  }
}
