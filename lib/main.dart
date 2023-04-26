import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poems_arabic/widgets/bottom_nav.dart';
import 'package:poems_arabic/widgets/login.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(PoemsArabic());
}

const primaryColor = Color.fromARGB(255, 116, 23, 139);
const secondaryColor = Color.fromARGB(255, 255, 184, 0);
const blackColor = Color.fromARGB(255, 9, 10, 10);

class PoemsArabic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appLabel = 'منسق الشعر';
    return MaterialApp(
      title: appLabel,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: secondaryColor,
          onSecondary: Colors.white,
          error: Color.fromARGB(255, 216, 76, 76),
          onError: Color.fromARGB(255, 216, 75, 75),
          background: Color.fromARGB(255, 235, 235, 235),
          onBackground: Color.fromARGB(255, 235, 235, 235),
          surface: primaryColor,
          onSurface: primaryColor,
        ),
        fontFamily: 'Noor',
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("ar", "AE"),
      ],
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      // problem here with login and bottom nav
      navigateAfterSeconds: const LoginScreen(),
      backgroundColor: Color.fromARGB(166, 116, 23, 139),
      image: Image.asset(
        'assets/images/logo.png',
        scale: 1.0,
      ),
      photoSize: 120,
      loaderColor: Colors.white,
    );
  }
}
