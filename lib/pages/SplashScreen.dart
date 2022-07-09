import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final Future<dynamic> Function() future;
  final Widget Function(Object) handleFinished;

  const LoadingPage(
      {Key? key, required this.future, required this.handleFinished})
      : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.future(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const SplashScreen();
          } else {
            return widget.handleFinished(snapshot.data!);
          }
        });
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red, Colors.black],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Center(
            child: Text(
              // TODO replace with logo
              "yours",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0)
                    .fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
