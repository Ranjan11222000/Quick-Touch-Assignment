import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/login_view.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDgft8UCfMK__m97iGFnfTUxyaXtSesnF4",
      appId: "1:323107356754:android:714f83e72017244eb1df8b",
      messagingSenderId: "323107356754",
      projectId: "quicktouch-a0a59",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}
