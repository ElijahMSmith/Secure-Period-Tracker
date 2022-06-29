import 'package:flutter/material.dart';

class CanaryPage extends StatelessWidget {
  const CanaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Canary"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This represents the canary page"),
      ),
    );
  }
}