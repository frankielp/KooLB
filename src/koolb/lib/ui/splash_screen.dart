import 'dart:math';

import 'package:flutter/material.dart';
import 'package:koolb/ui/sign_in_screen.dart';
import '../decoration/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;

  List<String> splashText = [
    "BOOK A HOTEL",
    "PLAN YOUR TRIP",
    "ENJOY YOUR JOURNEY"
  ];

  List<String> splashSubText = [
    "Get attractive offers to enjoy your trip with a variety of ride options",
    "Plan your dream and make your vision come to life with us",
    "Enjoy every second of your holiday. Make sure to have a fun and memorable trip"
  ];

  List<String> splashImage = [
    "assets/images/onboarding1.png",
    "assets/images/onboarding2.png",
    "assets/images/onboarding3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: ((value) {
                  setState(() {
                    currentPage = value;
                  });
                }),
                itemCount: splashText.length,
                itemBuilder: (context, index) => SplashContent(
                  text: splashText[index],
                  subtext: splashSubText[index],
                  image: splashImage[index],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashText.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(),
                    DefaulButton(
                      text: "Get Started",
                      press: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()));
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Turquois : const Color(0xFFDBDBDB),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class DefaulButton extends StatelessWidget {
  const DefaulButton({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton(
        onPressed: press,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Turquois),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.subtext,
    required this.image,
  }) : super(key: key);

  final String text, subtext, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 90),
        Text(
          text,
          style: const TextStyle(
            color: Turquois,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10,),
        Image.asset(
          image,
        ),
        SizedBox(height: 10,),
        Text(
          subtext,
          style: TextStyle(
            color: DarkGreen.withOpacity(0.6),
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}