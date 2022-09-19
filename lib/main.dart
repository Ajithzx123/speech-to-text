
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:welkin/HomeScreen/Speech_screen.dart';
import 'package:welkin/Onboarding/Otp.dart';
import 'package:welkin/Onboarding/login.dart';
import 'package:welkin/Onboarding/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: SpeechScreen(),
    routes: {
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'speechscreen' :(context) => SpeechScreen(),
      // 'otp' :(context) => OtpPage()
    },
    );
  }
}