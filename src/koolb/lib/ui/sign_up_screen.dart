import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:koolb/ui/renter/pages/home_page.dart';
import 'package:koolb/ui/sign_in_screen.dart';

import '../component/already_have_account_check.dart';
import '../component/or_divider.dart';
import '../component/row_of_social_icons.dart';
import '../component/text_field_container.dart';
import '../decoration/color.dart';
import '../main.dart';
import '../util/fire_auth.dart';
import '../util/validator.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  bool _passwordVisible = false;

  // @override
  // void initState() {
  //   _passwordVisible = false;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.infinity,
          height: size.height - keyboardHeight,
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
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
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: [
                        TextFieldContainer(
                          child: TextFormField(
                            controller: _nameTextController,
                            focusNode: _focusName,
                            validator: (value) => Validator.validateName(
                              name: value!,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              icon: const Icon(
                                Icons.text_fields,
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
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
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
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.008,
                  ),
                  _isProcessing
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: size.width * 0.85,
                          height: size.height * 0.05,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isProcessing = true;
                                    });

                                    if (_registerFormKey.currentState!
                                        .validate()) {
                                      User? user = await FireAuth
                                          .registerUsingEmailPassword(
                                        name: _nameTextController.text,
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text,
                                      );

                                      setState(() {
                                        _isProcessing = false;
                                      });

                                      if (user != null) {
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              // ProfilePage(user: user)),
                                              HomePage(
                                                  title: user.displayName!),
                                        ));
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(BlueJean),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(29))),
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
                            ],
                          ),
                        ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  AlreadyHaveAccountCheck(
                    login: false,
                    press: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),
                  OrDivider(),
                  const RowOfSocialIcons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
