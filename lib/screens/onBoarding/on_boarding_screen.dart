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
  int currentPage = 0;

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
        'devide': 'assets/images/onboarding/updevide3.svg',
        'deskripsi':
            'Kamu bisa dapet fitur Muslim seperti Al-Quran, Doa Pilihan, serta Jadwal Adzan..Jadi semua sudah ada di QuranHealer'
      },
      {
        'img': 'assets/images/onboarding/onboarding3.png',
        'judul': 'Daftar Gratis',
        'devide': 'assets/images/onboarding/updevide2.svg',
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
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
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
                    boardingData['boarding'][currentPage]['devide'],
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
                      Text(
                        boardingData['boarding'][currentPage]['judul'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 21,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          boardingData['boarding'][currentPage]['deskripsi'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6D6666),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        currentPage == 2 ? "" : "GET STARTED",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
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
                          currentPage != 2
                              ? InkWell(
                                  onTap: () {
                                    if (currentPage <
                                        boardingData['boarding'].length - 1) {
                                      _pageControllerDescription.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "LANJUT",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1E4A2A),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed('/boarding-2');
                                  },
                                  child: const Text(
                                    "GET STARTED",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF1E4A2A),
                                      fontWeight: FontWeight.w600,
                                    ),
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
