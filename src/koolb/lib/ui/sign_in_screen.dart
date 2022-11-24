import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koolb/component/or_divider.dart';
import 'package:koolb/component/row_of_social_icons.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/sign_up_screen.dart';

import '../component/already_have_account_check.dart';
import '../component/rounded_input_field.dart';
import '../component/text_field_container.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              "SIGN IN",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cyan,
              ),
            ),
            Image.asset(
              "assets/images/signin.png",
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
                  "LOGIN",
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
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpScreen();
                    },
                  ),
                );
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
