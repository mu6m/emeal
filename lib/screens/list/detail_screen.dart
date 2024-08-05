import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailScreen({super.key, required this.item});

  // Declare a field that holds the Todo.
  final dynamic item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(item['des']),
      ),
    );
  }
}
