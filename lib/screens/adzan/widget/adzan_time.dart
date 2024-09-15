import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdzanTime extends StatefulWidget {
  String jadwalShalat;
  String waktuShalat;
  AdzanTime({
    super.key,
    required this.jadwalShalat,
    required this.waktuShalat,
  });

  @override
  State<AdzanTime> createState() => _AdzanTimeState();
}

class _AdzanTimeState extends State<AdzanTime> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.jadwalShalat,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.waktuShalat,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 1,
          color: Color(0xFF8B8A8A),
        ),
      ],
    );
  }
}
