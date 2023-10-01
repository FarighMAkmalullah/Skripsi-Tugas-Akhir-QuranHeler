import 'package:flutter/material.dart';

class AdzanScreen extends StatefulWidget {
  const AdzanScreen({super.key});

  @override
  State<AdzanScreen> createState() => _AdzanScreenState();
}

class _AdzanScreenState extends State<AdzanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adzan'),
      ),
      body: Text('Adzan'),
    );
  }
}
