import 'package:flutter/material.dart';
import 'package:flutter_poc_v2/protected_screens/items.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.search,
              size: 30,
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Flexible(
                  child: Items(
                    name: "Cars",
                    img:
                        "assets/images/cars.png", // Ensure this path is correct
                    color: Colors.red,
                  ),
                ),
                Items(
                  name: "Properties",
                  img:
                      "assets/images/properties.jpg", // Ensure this path is correct
                  color: Colors.red,
                ),
                Items(
                  name: "Mobiles",
                  img: "assets/images/jobs.jpg", // Ensure this path is correct
                  color: Colors.red,
                ),
                Items(
                  name: "Jobs",
                  img:
                      "assets/images/mobiles.jpg", // Ensure this path is correct
                  color: Colors.red,
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: Color(0xffFFc100),
                      child: Text(
                        "See\nAll",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text("data"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
