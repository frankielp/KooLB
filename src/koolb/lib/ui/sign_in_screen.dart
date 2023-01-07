import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:koolb/component/or_divider.dart';
import 'package:koolb/component/row_of_social_icons.dart';
import 'package:koolb/data/global_data.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/admin/ad_navigation_bar.dart';
import 'package:koolb/ui/host/h_navigation_bar.dart';
import 'package:koolb/ui/renter/pages/home_page.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';
import 'package:koolb/ui/sign_up_screen.dart';
import 'package:koolb/user/koolUser.dart';

import '../component/already_have_account_check.dart';
import '../component/text_field_container.dart';
import '../component/fire_auth.dart';
import '../component/validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: double.infinity,
              height: size.height - keyboardHeight,
              child: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
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
                          height: size.height * 0.01,
                        ),
                        SizedBox(
                          width: size.width * 0.85,
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
                                  route();
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(BlueJean),
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
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        AlreadyHaveAccountCheck(
                          login: true,
                          press: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
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
          return (const SignUpScreen());
        },
      ),
    );
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    var uid = FirebaseFirestore.instance
        .collection('user')
        .where('email', isEqualTo: user!.email)
        .get()
        .then((QuerySnapshot documentSnapshot) {
      if (documentSnapshot.docs.isNotEmpty) {
//         String name = "user", email = "email";
// String? id;
// String authID = "id";
        final user = documentSnapshot.docs.first;
        name = user.get('name');
        email = user.get('email');
        id = user.id;
        authID = user.get('authId');
        String role = user.get('role');

        switch (role) {
          case 'Renter':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RenterPagesNavigation(),
              ),
            );
            break;

          case 'Host':
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HostPagesNavigator(),
              ),
            );
            break;

          default:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminPagesNavigator(),
              ),
            );
            break;
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
