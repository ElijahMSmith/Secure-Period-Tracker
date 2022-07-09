import 'dart:collection';
import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
        if(snapshot.data is Error){
          return const LoginForm(isError: true);
        } else if(snapshot.data == null) {
          return const SplashScreen();
        } else {
          return HomePages(calendarBox: snapshot.data as Box);
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

Future<HashMap> _calculatePinHash (HashMap values) async {
  HashMap results = HashMap();

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

  results["hash"] = hex.encode(hashedPinKey.bytes);
  results["userKey"] = pinKey;
  return results;
}

Future<String> _getRandKey(HashMap inputs) async {
  final storedBox = SecretBox(
    hex.decode(inputs["cipherText"]),
    nonce: hex.decode(inputs["nonce"]),
    mac: Mac(hex.decode(inputs["mac"])),
  );

  final loginAES = AesGcm.with256bits();
  return hex.encode(await loginAES.decrypt(storedBox, secretKey: inputs["userKey"]));
}

// returns box if match, Error if not
Future<dynamic> _checkPinHash(String pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  HashMap values = HashMap();
  values["pin"] = pin;
  values["salt"] = prefs.getString("salt")!;

  final HashMap results = await compute(_calculatePinHash, values);
  final storedHashedUserKey = prefs.getString("hashedUserKey")!;

  if (results["hash"] != storedHashedUserKey) {
    return Error();
  }

  values.clear();
  values["userKey"] = results["userKey"];
  values["cipherText"] = prefs.getString("randKeyCipherText");
  values["nonce"] = prefs.getString("randKeyNonce");
  values["mac"] = prefs.getString("randKeyMAC");

  final String randKeyStr = await compute(_getRandKey, values);
  final List<int> randKeyBytes = hex.decode(randKeyStr);

  final calendarBox = await Hive.openBox('calendarBox', encryptionCipher: HiveAesCipher(randKeyBytes));
  return calendarBox;
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
    return Scaffold(
      body: Form(
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
      ),
    );
  }
}
