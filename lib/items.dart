import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Items extends StatelessWidget {
  final String name;
  final String img;
  final Color color;
  const Items(
      {super.key, required this.name, required this.img, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: color)),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Image.asset(
                img,
                width: 200,
                height: 200,
              ),
            )),
        Text(name, style: GoogleFonts.poppins(fontSize: 15))
      ],
    );
  }
}
