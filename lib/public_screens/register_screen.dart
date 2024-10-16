import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc_v2/public_screens/login_screen.dart';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SizedBox textFieldDefaultGap = const SizedBox(height: 16);
  bool vissiblePassword = false;
  Future<void> registerUser(String name, String email, String password) async {
    final url = Uri.parse('http://localhost:8080/register');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // Registration successful
        log('User registered successfully');
        // You can navigate to a success screen or show a success message
      } else {
        // Registration failed
        log('Failed to register user. Status code: ${response.statusCode}');
        log('Response body: ${response.body}');
        // You can show an error message to the user
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      log('Error occurred while registering: $e');
      // You can show an error message to the user
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title:const Text("Registration Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            children: [
              CachedNetworkImage(
                height: 150,
                imageUrl:
                    "https://static.vecteezy.com/ti/vetor-gratis/p1/15271968-design-de-icone-plano-de-homem-de-negocios-conceito-de-icone-de-recurso-humano-e-empresario-icone-de-homem-em-estilo-plano-da-moda-simbolo-para-o-design-do-seu-site-logotipo-app-vetor.jpg/",
                // placeholder: (context, url) => CircularProgressIndicator(),
                // errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(
                "Welcome to The App\n Create your Account",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              textFieldDefaultGap,
              textFieldDefaultGap,
              TextFormField(
                controller: _nameController,
                maxLength: 100,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: "Enter Name",
                    label: Text("Name"),
                    prefixIcon: Icon(Icons.person_2_outlined),
                    counterText: "",
                    border: OutlineInputBorder()),
              ),
              textFieldDefaultGap,
              TextFormField(
                controller: _emailController,
                maxLength: 100,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: "Enter Email",
                    label: Text("Email"),
                    prefixIcon: Icon(Icons.email_outlined),
                    counterText: "",
                    border: OutlineInputBorder()),
              ),
              textFieldDefaultGap,
              TextFormField(
                controller: _passwordController,
                maxLength: 100,
                keyboardType: TextInputType.text,
                obscureText: vissiblePassword,
                decoration: InputDecoration(
                    hintText: "Enter Password",
                    label: const Text("Password"),
                    prefixIcon: const Icon(Icons.password_outlined),
                    suffixIcon: GestureDetector(
                        onTap: () {
                          vissiblePassword = !vissiblePassword;
                          setState(() {});
                        },
                        child: Icon(vissiblePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined)),
                    counterText: "",
                    border: const OutlineInputBorder()),
              ),
              textFieldDefaultGap,
              ElevatedButton(
                  onPressed: () async {
                    String name = _nameController.text;
                    // print('Name: $name');
                    
                    String email = _emailController.text;
                    String password = _passwordController.text;

                    log('Name: $name');
                    log('Email: $email');
                    log('Password: $password');
                    if (name.isEmpty || email.isEmpty || password.isEmpty) {
                      // Show an error message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill in all fields')),
                      );
                      return;
                    }

                    // Show a loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    );

                    // Call the API
                    log('name: $name');
                    log('email: $email');
                    log('password: $password');
                    await registerUser(name, email, password);

                    // Hide the loading indicator
                    Navigator.of(context).pop();
                  },
                  child: const Text("Register")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => const LoginScreen()));
                  },
                  child: const Text(
                    "Already have an Account",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
