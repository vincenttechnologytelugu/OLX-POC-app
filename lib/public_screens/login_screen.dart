import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../protected_screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SizedBox textFieldDefaultGap = const SizedBox(height: 16);
  bool visiblePassword = false;
  String? loginMessage;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await storage.read(key: 'auth_token');
    if (token != null) {
      navigateToHome();
    }
  }

  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse('http://localhost:8080/login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token']; // Assuming the API returns a token
        await storage.write(key: 'auth_token', value: token);

        setState(() {
          loginMessage = 'Login successful! Redirecting to home...';
        });

        await Future.delayed(const Duration(seconds: 5));
        navigateToHome();
      } else {
        setState(() {
          loginMessage = 'Login failed. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        loginMessage = 'Error occurred while logging in: $e';
      });
    }
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    String email = _emailController.text;
    String password = _passwordController.text;
    loginUser(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CachedNetworkImage(
                height: 150,
                imageUrl:
                    "https://static.vecteezy.com/ti/vetor-gratis/p1/15271968-design-de-icone-plano-de-homem-de-negocios-conceito-de-icone-de-recurso-humano-e-empresario-icone-de-homem-em-estilo-plano-da-moda-simbolo-para-o-design-do-seu-site-logotipo-app-vetor.jpg",
              ),
              Text(
                "Welcome Back\nPlease Login to Your Account",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              textFieldDefaultGap,
              if (loginMessage != null)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: loginMessage!.contains('successful')
                      ? Colors.green[100]
                      : Colors.red[100],
                  child: Text(
                    loginMessage!,
                    style: TextStyle(
                      color: loginMessage!.contains('successful')
                          ? Colors.green[800]
                          : Colors.red[800],
                    ),
                  ),
                ),
              textFieldDefaultGap,
              TextFormField(
                controller: _emailController,
                maxLength: 100,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Enter Email",
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.email_outlined),
                  counterText: "",
                  border: OutlineInputBorder(),
                ),
              ),
              textFieldDefaultGap,
              TextFormField(
                controller: _passwordController,
                maxLength: 100,
                keyboardType: TextInputType.text,
                obscureText: !visiblePassword,
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  label: const Text("Password"),
                  prefixIcon: const Icon(Icons.password_outlined),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
                      });
                    },
                    child: Icon(visiblePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined),
                  ),
                  counterText: "",
                  border: const OutlineInputBorder(),
                ),
              ),
              textFieldDefaultGap,
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to registration screen if needed
                },
                child: const Text("Don't have an account? Register here",
                    style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
