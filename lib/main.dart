import 'package:carbonwise_account_deletion/firebase_options.dart';
import 'package:carbonwise_account_deletion/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home.dart';
import 'data.dart';
import "auth.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CarbonWise Account Deletion',
        home: StreamBuilder(
          stream: auth.authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              initUserData();
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ));
  }
}
