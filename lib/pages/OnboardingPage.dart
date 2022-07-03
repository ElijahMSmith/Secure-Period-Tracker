import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'RegistrationForm.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  void _onOnboardingEnd(context) {
    /*Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(
        builder: (_) => const HomePages(), // TODO this is going to home rn but switch this to the reg screen
      ),
      (route) => false,
    );*/

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RegistrationPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                  color: Colors.black,
                  fontSize: DefaultTextStyle.of(context).style.fontSize),
              children: <TextSpan>[
                const TextSpan(text: 'Welcome to\n'),
                TextSpan(
                    text: 'yours',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.red.shade500)),
                const TextSpan(text: '.')
              ],
            ),
          ),
          body: "The only security-first period-tracking app.",
          image: Center(
            child: Text(
              // TODO replace with logo
              "logo",
              style: TextStyle(
                color: Colors.red.shade400,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 2.0)
                    .fontSize,
              ),
            ),
          ),
          reverse: false,
        ),
        PageViewModel(body: "#2", title: "Page placeholder"),
        PageViewModel(body: "#3", title: "Page placeholder"),
        PageViewModel(body: "#4", title: "Page placeholder"),
        PageViewModel(body: "#5", title: "Page placeholder"),
      ],
      onDone: () => _onOnboardingEnd(context),
      done: Text("Get Started", style: TextStyle(color: Colors.red.shade500),),
      next: Icon(Icons.arrow_forward, color: Colors.red.shade500,),
      isProgressTap: false,
      dotsDecorator: DotsDecorator(
        activeColor: Colors.red.shade500,
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
