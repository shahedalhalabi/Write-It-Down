import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:write_it_down/models/database.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = Database();
  await db.init();
  runApp(
    ChangeNotifierProvider(create: (context) => db,
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write It Down',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(211, 211, 211, 1)
          ).copyWith(
            primary: Color.fromRGBO(211, 211, 211, 1),
          ),
      ),
      home: const HomePage(title: 'Write It Down'),
    );
  }
}

