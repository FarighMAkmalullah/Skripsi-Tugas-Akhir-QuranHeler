import 'package:flutter/material.dart';
import 'package:quranhealer/screens/adzan/adzan_screen.dart';
import 'package:quranhealer/screens/adzan/adzan_view_model.dart';
import 'package:quranhealer/screens/adzan/detail_adzan_view_model.dart';
import 'package:quranhealer/screens/curhat/ustadz_view_model.dart';
import 'package:quranhealer/screens/dashboard/dashboard_view_model.dart';
import 'package:quranhealer/screens/doa/doa_screen.dart';
import 'package:quranhealer/screens/doa/doa_view_model.dart';
import 'package:quranhealer/screens/jawaban/jawaban_view_model.dart';
import 'package:quranhealer/screens/login/login_screen.dart';
import 'package:quranhealer/screens/login/login_view_model.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_autenticaton.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_screen.dart';
import 'package:quranhealer/screens/onBoarding/splash_screen.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/screens/profil/edit_profil_view_model.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
import 'package:quranhealer/screens/quran/detail_quran_view_model.dart';
import 'package:quranhealer/screens/quran/quran_sceen.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/register/register_screen.dart';
import 'package:quranhealer/screens/register/register_view_mode.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuranViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailSurahViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdzanViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailAdzanViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoaViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboarViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfilViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UstadzViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProfilViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllPostViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JawabanViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UstadzPostViewModel(),
        ),
      ],
      child: const QuranHealer(),
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
}

class QuranHealer extends StatelessWidget {
  const QuranHealer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      title: 'Quran Healer',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/quran': (context) => const QuranScreen(),
        '/adzan': (context) => const AdzanScreen(),
        '/doa': (context) => const DoaScreen(),
        '/screen': (context) => const SplashScreen(),
        '/boarding': (context) => const OnBoardingScreen(
              page: 0,
            ),
        '/boarding-2': (context) => const OnBoardingAutentication(),
        '/login': (context) => const LoginScreen(),
        '/daftar': (context) => const RegisterScreen(),
        // '/bottombar': (context) => const BottomBar(),
      },
    );
  }
}
