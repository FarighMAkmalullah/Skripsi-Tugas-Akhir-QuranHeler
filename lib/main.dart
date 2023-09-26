import 'package:flutter/material.dart';
import 'package:quranhealer/screens/quran/detail_quran_view_model.dart';
import 'package:quranhealer/screens/quran/quran_sceen.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';
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
        )
      ],
      child: const QuranHealer(),
    ),
  );
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
        '/': (context) => const QuranScreen(),
      },
    );
  }
}
