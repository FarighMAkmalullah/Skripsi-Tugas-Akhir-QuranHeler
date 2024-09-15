import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranhealer/core/init/untils/firebase_api.dart';
import 'package:quranhealer/firebase_options.dart';
import 'package:quranhealer/screens/adzan/adzan_screen.dart';
import 'package:quranhealer/screens/adzan/adzan_view_model.dart';
import 'package:quranhealer/screens/adzan/detail_adzan_view_model.dart';
import 'package:quranhealer/screens/curhat/ustadz_view_model.dart';
import 'package:quranhealer/screens/dashboard/dashboard_view_model.dart';
import 'package:quranhealer/screens/doa/doa_screen.dart';
import 'package:quranhealer/screens/doa/doa_view_model.dart';
import 'package:quranhealer/screens/hadist/hadist_detail_view_model.dart';
import 'package:quranhealer/screens/hadist/hadist_view_model.dart';
import 'package:quranhealer/screens/jawaban/jawaban_view_model.dart';
import 'package:quranhealer/screens/login/login_screen.dart';
import 'package:quranhealer/screens/login/login_view_model.dart';
import 'package:quranhealer/screens/notification/notification_screen.dart';
import 'package:quranhealer/screens/notification/notification_view_model.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_autenticaton.dart';
import 'package:quranhealer/screens/onBoarding/on_boarding_screen.dart';
import 'package:quranhealer/screens/onBoarding/splash_screen.dart';
import 'package:quranhealer/screens/post/all_post_view_model.dart';
import 'package:quranhealer/screens/post/ustadz_post_view_model.dart';
import 'package:quranhealer/screens/profil/edit_profil_view_model.dart';
import 'package:quranhealer/screens/profil/profil_view_model.dart';
import 'package:quranhealer/screens/quran/detail_quran_view_model.dart';
import 'package:quranhealer/screens/quran/quran_sceen.dart';
import 'package:quranhealer/screens/quran/quran_view_model.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quranhealer/screens/register/register_screen.dart';
import 'package:quranhealer/screens/register/register_view_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quranhealer/services/chat/chat_service.dart';
import 'package:quranhealer/services/notification_input/notification_input.dart';
import 'package:quranhealer/services/ustadz_chat/ustadz_chat_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'quran_healer',
        channelName: 'Quran Healer',
        channelDescription: 'Notification Channel',
      )
    ],
    debug: true,
  );
  await FirebaseApi().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => QuranViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailSurahViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdzanViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailAdzanViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DoaViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboarViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfilViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UstadzViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => EditProfilViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AllPostViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => JawabanViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UstadzPostViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatService(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatUstadzService(),
        ),
        ChangeNotifierProvider(
          create: (context) => HadistViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationInputService(),
        ),
        ChangeNotifierProvider(
          create: (context) => DetailHadistViewModel(),
        ),
      ],
      child: const QuranHealer(),
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});
}

class QuranHealer extends StatefulWidget {
  const QuranHealer({super.key});

  @override
  State<QuranHealer> createState() => _QuranHealerState();
}

class _QuranHealerState extends State<QuranHealer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      title: 'Quran Healer',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/quran': (context) => const QuranScreen(),
        '/adzan': (context) => const AdzanScreen(),
        '/doa': (context) => const DoaScreen(),
        '/screen': (context) => const SplashScreen(),
        '/boarding': (context) => const OnBoardingScreen(
              page: 0,
            ),
        '/boarding-2': (context) => const OnBoardingAutentication(),
        '/login': (context) => const LoginScreen(),
        '/daftar': (context) => const RegisterScreen(),
        // '/bottombar': (context) => const BottomBar(),
        '/notification_screen': (context) => const NotificationScreen(),
      },
    );
  }
}
