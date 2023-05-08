// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gamebox/view/game_list.dart.dart';
import 'package:gamebox/view/login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String error = '';

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      error = (e.toString());
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      error = (e.toString());
      return null;
    }
  }

  Future<void> signOut(context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      print('Usuário desconectado com sucesso');
    } catch (e) {
      print('Erro ao desconectar usuário: $e');
    }
  }
}

class FirebaseServiceAuth {
  static Future<FirebaseApp> initialize() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAsAovPmyMwxanTpO4isoUCAq7hrckogs8 ',
      appId: '1:321092308170:android:fc24a0b98eea711255b833',
      messagingSenderId: '321092308170 ',
      projectId: 'gamebox-2d86f',
    ));
    return firebaseApp;
  }
}
