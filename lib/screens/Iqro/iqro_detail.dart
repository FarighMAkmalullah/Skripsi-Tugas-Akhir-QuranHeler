import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class IqroDetail extends StatefulWidget {
  final String image;
  final int id;
  const IqroDetail({
    super.key,
    required this.image,
    required this.id,
  });

  @override
  State<IqroDetail> createState() => _IqroDetailState();
}

class _IqroDetailState extends State<IqroDetail> {
  @override
  Widget build(BuildContext context) {
    Uint8List bytes = base64Decode(widget.image);
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman ${widget.id}"),
        centerTitle: true,
        backgroundColor: const Color(0xFF0E6969),
        foregroundColor: Colors.white,
      ),
      body: Image.memory(
        bytes,
        fit: BoxFit.cover,
      ),
    );
  }
}
