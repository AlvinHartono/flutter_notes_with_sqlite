import 'package:flutter/material.dart';
import 'package:projext/SQLite/db_helper.dart';
import 'package:projext/models/user.dart';
import 'package:projext/screens/notes_screen.dart';
import 'package:projext/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;
  final db = DatabaseHelper();

  void login() async {
    var response = await db.login(
      User(username: username.text, password: password.text),
    );

    if (response == true) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Success'),
          backgroundColor: Colors.lightGreen,
        ),
      );

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Notes(),
      ));
    } else {
      isLoginTrue = true;
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('user not found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                        hintText: 'username',
                        icon: Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        } else if (value.trim().length < 4) {
                          return 'Username length is at least 4 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: password,
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        hintText: 'password',
                        icon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.trim().length < 8) {
                          return 'Password length is at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // login();
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const Notes(),
                          ));
                        }
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Sign Up'),
                    ),

                    //This Text widget will be disabled by default, and triggered if pass/user is incorrect
                    isLoginTrue
                        ? const Text(
                            "Username or Password is incorrect",
                            style: TextStyle(color: Colors.red),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
