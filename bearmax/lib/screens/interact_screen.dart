import 'package:flutter/material.dart';

class InteractScreen extends StatelessWidget {
  const InteractScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Your widget implementation
   return Scaffold(
    appBar: AppBar(
      title: const Text('Interact'),
    ),
    body: const Center(child: Text('Interact', style: TextStyle(fontSize: 60))),
   );
  }
}