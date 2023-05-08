// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamebox/controller/auth/auth_service.dart';
import 'package:gamebox/view/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await FirebaseServiceAuth.initialize();
  } catch (e) {
    print('Erro ao inicializar o Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de jogos',
      theme: ThemeData.dark().copyWith(
        iconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        primaryColor: Colors.deepPurple,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 235, 210, 130),
          selectionColor: Color.fromARGB(255, 235, 210, 130),
          selectionHandleColor: Color.fromARGB(255, 235, 210, 130),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
      home: LoginPage(),
    );
  }
}
