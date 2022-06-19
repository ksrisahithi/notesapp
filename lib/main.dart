import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/add_note.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/login_page.dart';
import 'package:notes_app/signup_page.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes app',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white
      ),
      home: LoginPage(),
    );
  }
}