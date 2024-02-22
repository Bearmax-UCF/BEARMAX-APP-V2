import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Your widget implementation
   return Scaffold(
    appBar: AppBar(
      title: const Text('Notes'),
    ),
    body: const Center(child: Text('Notes', style: TextStyle(fontSize: 60))),
   );
  }
}