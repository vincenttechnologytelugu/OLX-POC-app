import 'package:flutter/material.dart';

class HomeappbarScreen extends StatelessWidget {
  const HomeappbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: const Color.fromARGB(255, 173, 171, 171),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Padding(padding: EdgeInsets.only(top: 10)),
              const Text(
                "Olx",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 160),
              const Icon(
                Icons.location_on_outlined,
                size: 30,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (ctx) => const Location()));
                  },
                  child: const Text(
                    'Miyapur, Hyderabad',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
