// ignore_for_file: avoid_print

import 'package:firebase_playground/services/firebase_auth/auth_interface.dart';
import 'package:firebase_playground/services/firebase_auth/custom_firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final AuthInterface authController = CustomFirebaseAuth();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Email"),
                  ),
                  controller: emailText,
                ),
                const SizedBox(height: 20.0),
                TextField(
                  decoration: const InputDecoration(
                    label: Text("Email"),
                  ),
                  controller: passwordText,
                ),
                const SizedBox(height: 50.0),

                // Login
                ElevatedButton(
                  child: const Text("Sign in"),
                  onPressed: () async {
                    if (authController.isValidInputs(
                      email: emailText.text,
                      password: passwordText.text,
                    )) {
                      await authController
                          .doLogin(
                              email: emailText.text,
                              password: passwordText.text)
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: value
                                      ? const Text("Sucesso no Login")
                                      : const Text("Falha no Login"))));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Preencha os campos corretamente")));
                    }
                  },
                ),
                const SizedBox(height: 20.0),

                // Register
                ElevatedButton(
                  child: const Text("Sign up"),
                  onPressed: () async {
                    if (authController.isValidInputs(
                      email: emailText.text,
                      password: passwordText.text,
                    )) {
                      await authController
                          .registerUser(
                              email: emailText.text,
                              password: passwordText.text)
                          .then((value) => ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                                  content: value
                                      ? const Text("Sucesso no Registro")
                                      : const Text("Falha no Registro"))));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Preencha os campos corretamente")));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
