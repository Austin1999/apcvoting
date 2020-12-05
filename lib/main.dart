import 'package:flutter/material.dart';
import 'package:webapp/User.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:webapp/login_page.dart';
import 'package:webapp/thankyou.dart';

import 'User.dart';
import 'User.dart';
import 'admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APC Voting System',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UserPage());
  }
}
