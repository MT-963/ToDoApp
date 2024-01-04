import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/auth/authscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/screens/HomePage.dart';
import 'package:to_do_app/screens/SansorPage.dart';
import 'package:to_do_app/screens/TaskDetails.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        routes: {
          "homePage": (context) => HomePage(),
          "authScreen": (context) => AuthScreen(),
          "taskDetail": (context) => TaskDetail(),
          "sansorPage": (context) => SansorPage(),
        },
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser == null
            ? const AuthScreen()
            : HomePage(),
      );
}
