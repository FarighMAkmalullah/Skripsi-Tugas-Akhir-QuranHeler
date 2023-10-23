import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF239D6A).withOpacity(0.6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child:
                        Image.asset("assets/images/onboarding/onboarding1.png"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  child: SvgPicture.asset(
                    "assets/images/onboarding/updevide1.svg",
                    fit: BoxFit.fill,
                    // ignore: deprecated_member_use
                    color: const Color(0xFF239D6A).withOpacity(0.6),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(35),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Curhat Bareng Uztadz",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 21,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Ga perlu repot cari ustadz untuk masalah sehari-hari cukup curhat bareng ustadz dari QuranHealer biar dapet bimbingan dan nasihat Islami..",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6D6666),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "GET STARTED",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE38800),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text(
                            "LANJUT",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E4A2A),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
