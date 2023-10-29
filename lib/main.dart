import 'package:flutter/material.dart';
import 'package:quranhealer/screens/adzan/adzan_screen.dart';
import 'package:quranhealer/screens/adzan/adzan_view_model.dart';
import 'package:quranhealer/screens/adzan/detail_adzan_view_model.dart';
import 'package:quranhealer/screens/doa/doa_screen.dart';
import 'package:quranhealer/screens/doa/doa_view_model.dart';
import 'package:quranhealer/screens/login/login_screen.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_autenticaton.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_screen.dart';
import 'package:quranhealer/screens/quran/detail_quran_view_model.dart';
import 'package:quranhealer/screens/quran/quran_sceen.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';
import 'package:quranhealer/screens/onBoarding/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
      title: 'QuranHealer',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/quran': (context) => const QuranScreen(),
        '/adzan': (context) => const AdzanScreen(),
        '/doa': (context) => const DoaScreen(),
        '/screen': (context) => const SplashScreen(),
        '/boarding': (context) => const OnBoardingScreen(),
        '/boarding-2': (context) => const OnBoardingAutentication(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}
