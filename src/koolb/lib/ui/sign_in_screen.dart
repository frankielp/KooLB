import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koolb/component/or_divider.dart';
import 'package:koolb/component/row_of_social_icons.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/home_page.dart';
import 'package:koolb/ui/sign_up_screen.dart';

import '../component/already_have_account_check.dart';
import '../component/text_field_container.dart';
import '../util/fire_auth.dart';
import '../util/validator.dart';

class SignInScreen extends StatelessWidget {

  bool _passwordVisible = false;

  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();

  final _focusPassword = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  final _formKey = GlobalKey<FormState>();

  // @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              width: double.infinity,
              height: size.height,
              child: Form(
                key: _formKey,
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
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value!,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                          icon: const Icon(
                            Icons.person,
                            color: LightBlue,
                          ),
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextFieldContainer(
                      child: TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: !_passwordVisible,
                        validator: (value) => Validator.validatePassword(
                          password: value!,
                        ),
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
                              _passwordVisible = !_passwordVisible;
                            },
                          ),
                          border: InputBorder.none,
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            User? user =
                                await FireAuth.signInUsingEmailPassword(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text,
                                    context: context);
                            if (user != null) {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    // ProfilePage(user: user)),
                                    HomePage(title: user.displayName!),
                              ));
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(BlueJean),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
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
                    const RowOfSocialIcons(),
                  ],
                ),
              ),
            );
          }
          return (const SignUpScreen());
        },
      ),
    );
  }
}
