import 'package:flutter/material.dart';

class DisclaimersPage extends StatelessWidget {
  const DisclaimersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disclaimers"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This represents the disclaimers page"),
      ),
    );
  }
}