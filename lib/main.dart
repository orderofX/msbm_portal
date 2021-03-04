import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'package:url_launcher/url_launcher.dart';

import 'package:msbmportal_app/landingpage.dart';
//import 'package:msbmportal_app/webviewtest.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: false // optional: set false to disable printing logs to console
      );
  await Permission.storage.request();
  runApp(new MaterialApp(
    home: MyApp(),
    theme: ThemeData(accentColor: Color.fromRGBO(173, 0, 0, 1)),
    debugShowCheckedModeBanner: false,
  ));
}

///void main() => runApp(new MaterialApp(
///   home: MyApp(),
/// theme: ThemeData(accentColor: Color.fromRGBO(173, 0, 0, 1)),
///   debugShowCheckedModeBanner: false,

/// ));

//Splashscreen
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new Landing(),
        image: Image.asset('images/Logo2.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 150.0,
        onClick: () => print("Flutter Egypt"),
        loaderColor: Color.fromRGBO(173, 0, 0, 1));
  }
}
