import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onRefreshPressed;
  const ErrorScreen({super.key, required this.onRefreshPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFC9C7C7),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/icons/error/error.png',
                  height: 87,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text('Maaf sepertinya ada kesalahan'),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: onRefreshPressed,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Coba Lagi'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
