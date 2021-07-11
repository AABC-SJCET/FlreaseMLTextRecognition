import 'package:flutter/material.dart';
import 'package:mltext/screen/home.dart';

import 'screen/login.dart';
import 'screen/onBoard.dart';
import 'screen/textToSpeech.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.blue),
            iconTheme: IconThemeData(color: Colors.blue)),
        primarySwatch: Colors.blue,
      ),
      home: OnboardingExample(),
    );
  }
}
