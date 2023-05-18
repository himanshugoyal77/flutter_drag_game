import 'package:flutter/material.dart';
import 'package:flutter_dragndrop/screens/home_screen.dart';
import 'package:flutter_dragndrop/screens/select_avatar_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AvatarFinal(selectedIndex: 0),
    );
  }
}
