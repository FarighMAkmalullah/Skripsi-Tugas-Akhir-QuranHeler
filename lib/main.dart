import 'package:flutter/material.dart';

void main() {
  runApp(const QuranHealer());
}

class QuranHealer extends StatelessWidget {
  const QuranHealer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuranHealer',
      initialRoute: '/',
      routes: {
        '/': (context) => const QuranHealer(),
      },
    );
  }
}
