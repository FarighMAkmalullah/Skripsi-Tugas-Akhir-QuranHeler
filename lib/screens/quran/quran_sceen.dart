import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  late Future<void> quranDataViewModel;
  @override
  void initState() {
    final quranViewModel = Provider.of<QuranViewModel>(context, listen: false);
    quranDataViewModel = quranViewModel.fetchQuranViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran in QuranHealer'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
        future: quranDataViewModel,
        builder: (context, snapshot) {
          return const Center(
            child: Text('Quran Digital'),
          );
        },
      ),
    );
  }
}
