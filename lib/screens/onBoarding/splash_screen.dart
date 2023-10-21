// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF239D6A).withOpacity(0.65),
              const Color(0xFF239D6A).withOpacity(0.9),
              const Color(0xFF239D6A),
            ],
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 25, 0),
                      child: SvgPicture.asset(
                        "assets/images/splash1.svg",
                        // fit: BoxFit.cover,
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  "assets/images/splash3.svg",
                  fit: BoxFit.fill,
                  height: 200,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 99,
                      height: 78,
                      child: Image.asset("assets/logo/logo.png"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'QuranHealer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
