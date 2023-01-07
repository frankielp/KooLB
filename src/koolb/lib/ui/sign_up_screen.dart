import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:koolb/ui/renter/pages/home_page.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';
import 'package:koolb/ui/sign_in_screen.dart';

import '../component/already_have_account_check.dart';
import '../component/or_divider.dart';
import '../component/row_of_social_icons.dart';
import '../component/text_field_container.dart';
import '../decoration/color.dart';
import '../component/fire_auth.dart';
import '../component/validator.dart';

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

  var options = [
    'Renter',
    'Host',
    'Admin',
  ];
  var _currentItemSelected = "Renter";
  var role = "Renter";

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
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: size.height * 0.1),
            alignment: Alignment.center,
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
                      SizedBox(
                        height: size.height * 0.008,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Choose your role ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: BlueJean,
                            ),
                          ),
                          DropdownButton<String>(
                            dropdownColor: Colors.white,
                            isDense: true,
                            isExpanded: false,
                            iconEnabledColor: BlueJean,
                            focusColor: BlueJean,
                            items: options.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: const TextStyle(
                                    color: BlueJean,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValueSelected) {
                              setState(() {
                                _currentItemSelected = newValueSelected!;
                                role = newValueSelected;
                              });
                            },
                            value: _currentItemSelected,
                          ),
                        ],
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
                                      postDetailsToFirestore(role);
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                        builder: (context) =>
                                            // ProfilePage(user: user)),
                                            SignInScreen(),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
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
    );
  }

  postDetailsToFirestore(String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('user');
    ref.doc(user!.uid).set({'email': _emailTextController.text, 'role': role});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
  }

  createUser {
    // TODO: create user in Firebase
    // TODO: create role user
  }
}
