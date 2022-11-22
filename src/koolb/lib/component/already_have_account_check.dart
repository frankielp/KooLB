import 'package:flutter/material.dart';

import '../decoration/color.dart';

class AlreadyHaveAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAccountCheck({
    Key? key, this.login = true, required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an account? " : "Already have an account? ",
          style: TextStyle(color: BlueJean),
        ),
        GestureDetector (
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style:
                TextStyle(color: BlueJean, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}