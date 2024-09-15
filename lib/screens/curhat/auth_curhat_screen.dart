import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/curhat/choose_ustadz_screen.dart';
import 'package:quranhealer/screens/error/error_screen.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
import 'package:quranhealer/screens/ustadz/ustadz_screen.dart';

class AuthCurhatScreen extends StatefulWidget {
  const AuthCurhatScreen({super.key});

  @override
  State<AuthCurhatScreen> createState() => _AuthCurhatScreenState();
}

class _AuthCurhatScreenState extends State<AuthCurhatScreen> {
  late Future detailDataFuture;
  @override
  void initState() {
    super.initState();

    final detailViewModel =
        Provider.of<ProfilViewModel>(context, listen: false);

    detailDataFuture = detailViewModel.getProfilDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfilViewModel>(builder: (
      context,
      provider,
      _,
    ) {
      final detail = provider.detailUser;
      return FutureBuilder(
        future: detailDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            if (detail!.role == 'user') {
              return const ChooseUstadzScreen();
            } else {
              return UstadzScreen(
                nameUstadz: detail.name,
                email: detail.email,
                spesialisasi: detail.email == 'aris@gmail.com'
                    ? "Al-Quran"
                    : detail.email == 'untung@gmail.com'
                        ? "Fiqih"
                        : detail.email == 'irfan@gmail.com'
                            ? "Hadist"
                            : detail.email == "suparyanto@gmail.com"
                                ? "Sejarah Kebudayaan Islam"
                                : "Ustadz Biasa",
                userId: detail.user_id,
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorScreen(onRefreshPressed: () {
                provider.getProfilDetail();
              }),
            );
          } else {
            return Container();
          }
        },
      );
    });
  }
}
