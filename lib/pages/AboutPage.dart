import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("This represents the about page"),
      ),
    );
  }
}