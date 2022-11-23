import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/PageAcceuil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Onzek',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: HomePage(title: 'Onzek'),
    );
  }
}
