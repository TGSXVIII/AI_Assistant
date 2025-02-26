import 'package:sam_ai/dashboard.dart';
import 'package:sam_ai/account.dart';
import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 243, 237, 247),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Profile
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Account()),
                ),
                icon: const Icon(Icons.person_2_rounded),
              ),
              const SizedBox(height: 2),
              const Text(
                'Profile',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // Home
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dashboard()),
                ),
                icon: const Icon(Icons.cottage),
              ),
              const SizedBox(height: 2),
              const Text(
                'Home',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
