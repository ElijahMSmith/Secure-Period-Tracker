import 'dart:collection';
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SplashScreen.dart';
import 'HomePages.dart';

class LoginLoadingPage extends StatefulWidget {
  final String pin;

  const LoginLoadingPage({Key? key, required this.pin}) : super(key: key);

  @override
  State<LoginLoadingPage> createState() => _LoginLoadingPageState();
}

class _LoginLoadingPageState extends State<LoginLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkPinHash(widget.pin),
      builder: (context, snapshot) {
        if(snapshot.data == null) {
          return const SplashScreen();
        } else if(snapshot.data == true) {
          return const HomePages();
        } else {
          return const LoginPage(isError: true);
        }
      },
    );
  }
}

void _submitLogin(GlobalKey<FormState> key, BuildContext context, String pin) {
  if (key.currentState!.validate()) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginLoadingPage(pin: pin)),
      (route) => false,
    );
  }
}

Future<String> _calculatePinHash (HashMap values) async {
  final SecretKey pinBytes = SecretKey(utf8.encode(values["pin"]));

  final pdkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha512(),
    iterations: 150000,
    bits: 256,
  );

  final salt = SecretKey(hex.decode(values["salt"]));

  final pinKey = await pdkdf2.deriveKey(
    secretKey: pinBytes,
    nonce: await salt.extractBytes(),
  );

  final sha512 = Sha512();
  final hashedPinKey = await sha512.hash(await pinKey.extractBytes());

  return hex.encode(hashedPinKey.bytes);
}

// returns true if match, false if not
Future<bool> _checkPinHash(String pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  HashMap values = HashMap();
  values["pin"] = pin;
  values["salt"] = prefs.getString("salt")!;

  final hashedPinKey = await compute(_calculatePinHash, values);
  final storedHashedUserKey = prefs.getString("hashedUserKey")!;

  final result = hashedPinKey == storedHashedUserKey;

  return result;
}

class LoginForm extends StatefulWidget {
  final bool isError;

  const LoginForm({Key? key, required this.isError}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Enter PIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _pin,
              autocorrect: false,
              enableSuggestions: false,
              enableIMEPersonalizedLearning: false,
              obscureText: true,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your PIN';
                }
                return null;
              },
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (value) {
                _submitLogin(_formKey, context, _pin.text);
              },
              decoration: InputDecoration(
                errorText: widget.isError ? "Incorrect PIN. Please try again." : null,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submitLogin(_formKey, context, _pin.text);
              },
              child: const Text('Log In'),
            )
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  final bool isError;

  const LoginPage({Key? key, required this.isError}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginForm(isError: widget.isError),
    );
  }
}
