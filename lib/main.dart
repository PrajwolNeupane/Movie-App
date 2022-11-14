import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/Screens/Cast_Detail.dart';
import 'package:movie_app/Screens/HomeScreen.dart';
import 'package:movie_app/Screens/Home_Detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreen(),
        '/detail': (context) => Home_Detail(),
        '/cast_detail': (context) => Cast_Detail(),
      },
    );
  }
}
