import 'package:flutter/material.dart';

class NotifocationWidget extends StatefulWidget {
  const NotifocationWidget({super.key});

  @override
  State<NotifocationWidget> createState() => _LogoAndAccountWidgetState();
}

class _LogoAndAccountWidgetState extends State<NotifocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 28,
                height: 23,
                child: Image.asset("assets/logo/logo.png"),
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                'QURANHEALER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          SizedBox(
            width: 28,
            height: 23,
            child: Image.asset("assets/icons/dashboard/notification.png"),
          ),
        ],
      ),
    );
  }
}
