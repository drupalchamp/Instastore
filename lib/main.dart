import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instastore/scoped-models/main.dart';

import 'package:instastore/splashScreen.dart';
import 'package:instastore/utils/locator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:instastore/pages/homePage.dart';
//import 'splashScreen.dart';

//void main() => runApp(MyApp());


void main() {
 // debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  setupLocator();
  runApp(
    MyApp()
    /*DevicePreview(
      enabled: !kReleaseMode, // Ensures that it is disabled in release mode
      builder: (context) => MyApp(),
    )*/
  );
}




/*class MyApp extends StatelessWidget {
  final MainModel _model = MainModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //locale: DevicePreview.of(context).locale, // <--- Add the locale
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        home: SplashScreen()
    );
  }
}*/

class MyApp extends StatefulWidget {
  final MainModel _model = MainModel();
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.loggedInUser();
    _model.fetchCurrentOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/home',
        routes: {
          '/home' : (context) => HomeScreen()
        },
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.white,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
