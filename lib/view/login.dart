// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamebox/controller/auth/auth_service.dart';
import 'package:gamebox/view/game_list.dart.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitCubeGrid(
                    size: 55,
                    color: Color.fromARGB(255, 235, 210, 130),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AnimatedOpacity(
                    opacity: 1.0,
                    duration: Duration(milliseconds: 1),
                    curve: Curves.decelerate,
                    child: Text(
                      'Game',
                      style: TextStyle(
                        fontSize: 50,
                      ),
                    ),
                  ),
                  Text(
                    'Box',
                    style: TextStyle(
                        fontSize: 50,
                        color: Color.fromARGB(255, 235, 210, 130)),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Email', prefixIcon: Icon(Icons.email , color: Color.fromARGB(255, 235, 210, 130),)),
                        validator: (val) =>
                            val!.isEmpty ? 'Digite um email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 235, 210, 130),),
                        ),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Digite uma senha com 6+ caracteres'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            dynamic result =
                                await _auth.signIn(email, password);
                            if (result == null) {
                              setState(() => error =
                                  'Não foi possível fazer login com essas credenciais');
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GameList()),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 40),
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(color: Colors.black),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 235, 210, 130),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                            style: TextStyle(color: Colors.black), 'Login'),
                      ),
                      const SizedBox(height: 20.0),
                      const Text('Não tem uma conta?'),
                      const SizedBox(height: 12.0),
                      ElevatedButton(
                        onPressed: () async {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() =>
                                error = 'Não foi possível criar uma conta');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(_auth.error,
                                  style: TextStyle(color: Colors.white)),
                            ));
                          }
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Cadastro feito com sucesso!',
                                    style: TextStyle(color: Colors.white)),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 40),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              color: Color.fromARGB(255, 235, 210, 130),
                              width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                            style: TextStyle(color: Colors.black),
                            'Cadastre-se'),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
