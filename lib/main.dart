import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/first_page.dart';
import 'package:namer_app/pages/home_page.dart';
import 'package:namer_app/pages/profile_page.dart';
import 'package:provider/provider.dart';

import 'pages/settings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        '/Home': (context) => HomePage(),
        '/Profile': (context) => ProfilePage(),
        '/Settings': (context) => SettingPage(),
      },
    );
  }
}
