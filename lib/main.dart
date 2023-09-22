import 'package:flutter/material.dart';

void main() {
  runApp(const QuranHealer());
}

class QuranHealer extends StatelessWidget {
  const QuranHealer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("QuranHealer"),
        ),
        body: const Center(
          child: Text("Fitur B"),
        ),
      ),
    );
  }
}
