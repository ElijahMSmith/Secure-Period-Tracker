import 'package:flutter/material.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({Key? key}) : super(key: key);

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add data point"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text("Placeholder for new event form"),
      ),
    );
  }
}
