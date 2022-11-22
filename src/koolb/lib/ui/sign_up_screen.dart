import 'dart:ui';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../component/already_have_account_check.dart';
import '../component/or_divider.dart';
import '../component/rounded_input_field.dart';
import '../component/row_of_social_icons.dart';
import '../component/text_field_container.dart';
import '../decoration/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGN UP",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cyan,
              ),
            ),
            Image.asset(
              "assets/images/signup.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your email",
              icon: Icons.person,
              onChanged: (value) {
                //CODE HERE
              },
            ),
            TextFieldContainer(
              child: TextField(
                obscureText: !_passwordVisible,
                onChanged: ((value) {
                  // CODE HERE
                }),
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: const Icon(
                    Icons.lock,
                    color: LightBlue,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: LightBlue,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.05,
              child: TextButton(
                onPressed: (() {
                  //CODE HERE
                }),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(BlueJean),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(29))),
                ),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AlreadyHaveAccountCheck(
              login: false,
              press: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            OrDivider(),
            RowOfSocialIcons(),
          ],
        ),
      ),
    );
  }
}



