import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kwallpapers/pages/home.dart';
import 'package:kwallpapers/utils/widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K Wallpapers',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Poppins'),
      home: AnimatedSplashScreen(
        splash: appName(),
        backgroundColor: Colors.pinkAccent.shade400,
        duration: 1500,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const Home(),
      ),
    );
  }
}
