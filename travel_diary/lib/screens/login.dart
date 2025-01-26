import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_diary/screens/register.dart';

import '../providers/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isValidEmail(String email) {
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final passwordVisibility = Provider.of<DestinationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  hintText: "Enter your email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!isValidEmail(value)) {
                    return 'Email not valid!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: passwordVisibility.isObscure,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurple[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.deepPurple),
                  hintText: "Enter your password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisibility.isObscure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.deepPurple,
                    ),
                    onPressed: () {
                      passwordVisibility.toggleVisibility();
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password should not have less than 6 characters.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Register!",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                icon: const Icon(Icons.check_circle_outline_sharp),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await AuthService()
                        .login(emailController.text, passwordController.text, context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill input')),
                    );
                  }
                },
                label: const Text('Submit', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
