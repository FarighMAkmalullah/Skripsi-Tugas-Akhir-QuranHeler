import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/core/init/untils/shared_preference.dart';
import 'package:quranhealer/screens/notification/notification_screen.dart';
import 'package:quranhealer/screens/notification/notification_view_model.dart';

class NotifocationWidget extends StatefulWidget {
  const NotifocationWidget({super.key});

  @override
  State<NotifocationWidget> createState() => _LogoAndAccountWidgetState();
}

class _LogoAndAccountWidgetState extends State<NotifocationWidget> {
  // late Timer timer1;
  // bool _isTimerActive = false;

  @override
  void initState() {
    super.initState();
    loged();
    // if (!_isTimerActive) {
    //   _isTimerActive = true;
    //   timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
    //     if (mounted) {
    //       Provider.of<NotificationViewModel>(context, listen: false)
    //           .fetchBlmDibaca();
    //     } else {
    //       timer.cancel();
    //     }
    //   });
    // }
  }

  // @override
  // void dispose() {
  //   if (_isTimerActive) {
  //     timer1.cancel();
  //     _isTimerActive = false;
  //   }
  //   super.dispose();
  // }
  bool notif = false;

  Future loged() async {
    var token = await getToken();
    if (token.toString() == "null") {
      setState(() {
        notif = false;
      });
    } else {
      setState(() {
        notif = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationViewModel>(builder: (context, provider, _) {
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
            notif
                ? InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 28,
                          height: 23,
                          child: Image.asset(
                              "assets/icons/dashboard/notification.png"),
                        ),
                        // StreamBuilder<String>(
                        //   stream: provider.blmDibacaStream,
                        //   builder: (context, snapshot) {
                        //     if (snapshot.connectionState == ConnectionState.waiting) {
                        //       return Container();
                        //     } else if (snapshot.hasError) {
                        //       return Container();
                        //     } else if (snapshot.hasData) {
                        //       return Positioned(
                        //         top: 5,
                        //         right: 5,
                        //         child: CircleAvatar(
                        //           radius: 10,
                        //           backgroundColor: Colors.orange,
                        //           child: Text(
                        //             "${snapshot.data}",
                        //             style: const TextStyle(
                        //                 color: Colors.white, fontSize: 10),
                        //           ),
                        //         ),
                        //       );
                        //     } else {
                        //       return Container();
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
