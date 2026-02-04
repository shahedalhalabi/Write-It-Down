import 'package:flutter/material.dart';
//import 'oldhomepage.dart';
import 'home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:write_it_down/models/firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => FirestoreService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write It Down',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(250, 249, 240, 1)
          ).copyWith(
            primary: Color.fromRGBO(250, 249, 240, 1),
            secondary: Color.fromRGBO(246, 240, 215, 1),
            tertiary: Color.fromRGBO(156, 171, 132, 1),
          ),
      ),
      home: const HomePage(title: "Write It Down"),
    );
  }
}

