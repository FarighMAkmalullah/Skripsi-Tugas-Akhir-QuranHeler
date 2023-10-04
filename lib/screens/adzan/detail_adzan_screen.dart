import 'package:flutter/material.dart';

class AdzanDetail extends StatefulWidget {
  const AdzanDetail({super.key});

  @override
  State<AdzanDetail> createState() => _AdzanDetailState();
}

class _AdzanDetailState extends State<AdzanDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Adzan'),
      ),
      body: Center(
        child: Text('Adzan'),
      ),
    );
  }
}
