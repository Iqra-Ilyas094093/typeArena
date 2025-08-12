import 'package:flutter/material.dart';

class TypingTesttScreen extends StatelessWidget {
  const TypingTesttScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        actions: [
          Row(
            children: [
              Image.asset('assets/images/logo.png')
            ],
          )
        ],
      ),
    );
  }
}
