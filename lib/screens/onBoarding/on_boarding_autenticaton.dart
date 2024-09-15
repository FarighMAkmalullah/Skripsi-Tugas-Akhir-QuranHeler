import 'package:flutter/material.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/screens/bottombar/bottombar_widget.dart';
import 'package:quranhealer/screens/login/login_screen.dart';
import 'package:quranhealer/screens/register/register_screen.dart';
import 'package:quranhealer/screens/terms_and_privacy_policy/privacy_policy.dart';
import 'package:quranhealer/screens/terms_and_privacy_policy/terms_screen.dart';

class OnBoardingAutentication extends StatelessWidget {
  const OnBoardingAutentication({super.key});

  Future<String> isiToken() async {
    return '$token';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          Navigator.of(context).pushReplacementNamed('/boarding');
        }
      },
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0E6969).withOpacity(0.65),
                const Color(0xFF0E6969).withOpacity(0.9),
                const Color(0xFF0E6969),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    "Selamat Datang di QuranHealer",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Image.asset(
                    "assets/images/onboarding/onboarding4.png",
                    height: 120,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Bentuk border
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const LoginScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = const Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              'assets/icons/onboarding/login.png',
                              height: 28,
                              width: 28,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'LOGIN WITH QURAN HEALER',
                              style: TextStyle(color: Color(0xFF02410D)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Bentuk border
                            ),
                          ),
                        ),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Mohon Maaf'),
                                content: const Text(
                                    'Fitur ini masih dalam pengembangan'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              'assets/icons/onboarding/google.png',
                              height: 28,
                              width: 28,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'LOGIN WITH GOOGLE',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FractionallySizedBox(
                    widthFactor: 1.0,
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Bentuk border
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BottomBar(
                                dashboardIndex: 0,
                                currentIndex: 0,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Image.asset(
                              'assets/icons/onboarding/login.png',
                              height: 28,
                              width: 28,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              'MASUK TANPA LOGIN',
                              style: TextStyle(color: Color(0xFF02410D)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const Text(
                "Dont have an account ?",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const RegisterScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = const Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: const Text(
                  "Register Here",
                  style: TextStyle(
                    color: Color(0xFFF0D338),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              //=========================================================
              const Text(
                "By continue you agree to our",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Terms ",
                      style: TextStyle(
                        color: Color(0xFFF0D338),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Text(
                    "& ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PrivacyPolicyScreen(),
                          ));
                    },
                    child: const Text(
                      "Privacy Policy ",
                      style: TextStyle(
                        color: Color(0xFFF0D338),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
