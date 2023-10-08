import 'package:flutter/material.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doa Pilihan'),
      ),
      body: const Center(
        child: Text('Doa Pilihan'),
      ),
    );
  }
}
