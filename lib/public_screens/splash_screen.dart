import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_poc_v2/public_screens/register_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
Timer(const Duration(seconds:3),(){
Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>const RegisterScreen()), (route)=>false);
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf-Y8C5Du0eP9538yM_49j0UYuPMi4RBFwwQ&s",
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}
