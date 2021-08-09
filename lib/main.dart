import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instsport/screens/end_screen.dart';
import 'package:instsport/screens/gameplay_screen.dart';
import 'package:instsport/screens/home_screen.dart';
import 'package:instsport/screens/setting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays ([]);

  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((value) =>
  runApp(
      EasyLocalization(
          supportedLocales: [
            Locale('en'),
            Locale('ru'),
          ],
          path: "assets/translations",
          fallbackLocale: Locale("en"),
          saveLocale: false,
          child : MyApp()
      ),

  ),);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
        theme: ThemeData(fontFamily: "VisbyCF"),
        debugShowCheckedModeBanner: false,
        // locale: _locale,

        home: HomeScreen(),
        routes: {
          "/1home": (context) => HomeScreen(),
          "/2setting": (context) => SettingScreen(),
          "/3gameplay": (context) => GamePlayScreen(),
          "/4end": (context) => EndScreen(),

        },

    );
  }
}

