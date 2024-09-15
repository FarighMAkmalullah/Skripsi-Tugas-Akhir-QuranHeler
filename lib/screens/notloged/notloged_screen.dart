import 'package:flutter/material.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_autenticaton.dart';

class NotLogedScreen extends StatefulWidget {
  const NotLogedScreen({super.key});

  @override
  State<NotLogedScreen> createState() => _NotLogedScreenState();
}

class _NotLogedScreenState extends State<NotLogedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 140,
            child: Image.asset(
              "assets/images/onboarding/onboarding4.png",
              fit: BoxFit.contain,
            ),
          ),
          const Text(
            "Maaf Anda belum Login",
            style: TextStyle(fontSize: 20),
          ),
          const Text("Silahkan Login dengan menekan tombol di bawah..."),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FractionallySizedBox(
              widthFactor: 1.0,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        const Color(0xFF0E6969),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnBoardingAutentication(),
                        ),
                      );
                    },
                    child: Text("Login")),
              ),
            ),
          )
        ],
      ),
    );
  }
}
