import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'SCREENmain.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyAhe-IKlFTHTgnaTrQoyP0yJiDigcywtEY",
          authDomain: "runningapp-bd179.firebaseapp.com",
          databaseURL: "https://runningapp-bd179-default-rtdb.firebaseio.com",
          projectId: "runningapp-bd179",
          storageBucket: "runningapp-bd179.appspot.com",
          messagingSenderId: "404426056652",
          appId: "1:404426056652:web:54c7273b5b1ef3d22e7369",
          measurementId: "G-CD95WSYQY9"
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MB Bank',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const SCREENmain(),
    );
  }
}