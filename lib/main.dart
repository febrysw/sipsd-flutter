import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:sipsd/bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBLTzKwJh9uzimRx70xFu1nRUvawK_bCS0",
      appId: "1:684427965140:android:e5a3e3a38959e5588c4141",
      messagingSenderId: "684427965140",
      projectId: "sipsd-f82ad",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'SIPSD App', home: Bar());
  }
}
