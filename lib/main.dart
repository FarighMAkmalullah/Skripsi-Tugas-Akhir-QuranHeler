import 'package:flutter/material.dart';
import 'package:quranhealer/screens/quran/quran_sceen.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuranViewModel(),
        ),
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
      title: 'QuranHealer',
      initialRoute: '/',
      routes: {
        '/': (context) => const QuranScreen(),
      },
    );
  }
}
