import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/screens/auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:we_chat/screens/chat.dart';
import 'package:we_chat/screens/splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const Center(child: CircularProgressIndicator());
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            return const ChatScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}
