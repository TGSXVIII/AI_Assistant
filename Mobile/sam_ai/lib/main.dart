import 'package:sam_ai/templates/footerOnlyHome.dart';
import 'package:flutter/material.dart';

import 'brickBreaker.dart';
import 'login.dart';
import 'signup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/signup': (context) => const Signup(),
        '/login': (context) => const Login(),
        '/brickBreaker': (context) => BrickBreaker(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 51, 0, 80),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/mikkelfonden.png', height: 26, width: 220),
          const SizedBox(height: 20),
          Image.asset('assets/qonnect.png', height: 50, width: 250),
          const Align(
            alignment: Alignment.center,
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6F58C9),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6F58C9),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Sign up',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 50,
            width: 140,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff6F58C9),
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Birck Breaker',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/brickBreaker');
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const FooterOnlyHome(),
    );
  }
}
