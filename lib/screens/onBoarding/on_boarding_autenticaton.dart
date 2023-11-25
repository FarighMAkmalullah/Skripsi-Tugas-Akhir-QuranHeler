import 'package:flutter/material.dart';

class OnBoardingAutentication extends StatelessWidget {
  const OnBoardingAutentication({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed('/boarding');
        return false;
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
                const Color(0xFF239D6A).withOpacity(0.65),
                const Color(0xFF239D6A).withOpacity(0.9),
                const Color(0xFF239D6A),
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
                          backgroundColor: MaterialStateProperty.all(
                            const Color(0xFF1F542E),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Bentuk border
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
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
                            const Text('LOGIN WITH QURAN HEALER'),
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
                  Navigator.of(context).pushNamed('/daftar');
                },
                child: const Text(
                  "Register Here",
                  style: TextStyle(
                    color: Color(0xFFF0D338),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              //=========================================================
              const Text(
                "By continue you agree to our",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Terms ",
                    style: TextStyle(
                      color: Color(0xFFF0D338),
                    ),
                  ),
                  Text(
                    "& ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Privacy Policy ",
                    style: TextStyle(
                      color: Color(0xFFF0D338),
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
