import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoardingScreen> {
  final PageController _pageControllerDescription = PageController();

  Map<String, dynamic> boardingData = {
    'boarding': [
      {
        'img': 'assets/images/onboarding/onboarding1.png',
        'judul': 'Curhat Bareng Ustadz',
        'devide': 'assets/images/onboarding/updevide1.svg',
        'deskripsi':
            'Ga perlu repot cari ustadz untuk masalah sehari-hari cukup curhat bareng ustadz dari QuranHealer biar dapet bimbingan dan nasihat Islami..'
      },
      {
        'img': 'assets/images/onboarding/onboarding2.png',
        'judul': 'Fitur Muslim',
        'devide': 'assets/images/onboarding/updevide2.svg',
        'deskripsi':
            'Kamu bisa dapet fitur Muslim seperti Al-Quran, Doa Pilihan, serta Jadwal Adzan..Jadi semua sudah ada di QuranHealer'
      },
      {
        'img': 'assets/images/onboarding/onboarding3.png',
        'judul': 'Daftar Gratis',
        'devide': 'assets/images/onboarding/updevide3.svg',
        'deskripsi':
            'Kamu bisa daftar di QuranHealer dengan gratis tanpa dipungut biaya sedikitpun..'
      }
    ]
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageControllerDescription,
                itemCount: boardingData['boarding'].length,
                itemBuilder: (context, index) {
                  final boarding = boardingData['boarding'][index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF239D6A).withOpacity(0.6),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Image.asset(boarding['img']),
                        ),
                      ],
                    ),
                  );
                }),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Curhat Bareng Uztadz",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 21,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Ga perlu repot cari ustadz untuk masalah sehari-hari cukup curhat bareng ustadz dari QuranHealer biar dapet bimbingan dan nasihat Islami..",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6D6666),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "GET STARTED",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFE38800),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageControllerDescription,
                            count: 3,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: Color(0xFF1E4A2A),
                              dotColor: Color(0xFFC3BDBD),
                              dotHeight: 14,
                              dotWidth: 14,
                            ),
                          ),
                          const Text(
                            "LANJUT",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E4A2A),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
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
