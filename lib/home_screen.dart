import 'package:flutter/material.dart';
import 'package:flutter_poc_v2/protected_screens/categories_model.dart';
import 'package:flutter_poc_v2/protected_screens/dashboard_screen.dart';
import 'package:flutter_poc_v2/protected_screens/homeappbar_screen.dart';
import 'package:flutter_poc_v2/protected_screens/items.dart';
import 'package:flutter_poc_v2/protected_screens/shop_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../public_screens/login_screen.dart';
//import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_poc_v2/protected_screens/shopping_cart.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<void> _logout(BuildContext context) async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'auth_token');
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  int currentindex = 2;
  final pageController = PageController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   pageController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: HomeappbarScreen(),
      ),

      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.logout),
      //     onPressed: () => _logout(context),
      //   ),
      // ],
      body: Column(
        children: [
          PageView(
            controller: pageController,
            children: [
              CategoriesModel(),
              ShopScreen(),
              Items(name: "", img: "", color: Colors.red),
            ],
          ),
          Image.asset("assets/images/cars.jpg")
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        items: [
          const Icon(
            Icons.home,
            color: Colors.white,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (ctx) => DashboardScreen()));
            },
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          Icon(
            Icons.star,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xffDD9718),
        color: const Color(0xffFFc700),
        index: currentindex,
        height: 50,
        onTap: (index) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        },
      ),
    );
  }
}
