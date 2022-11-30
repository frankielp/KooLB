import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:koolb/component/social_icon.dart';
import 'package:provider/provider.dart';
import 'package:koolb/util/fire_auth.dart';

class SignInWithFacebook extends StatefulWidget{
  const SignInWithFacebook({Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SignInWithFacebook();
  }
}

class _SignInWithFacebook extends State<SignInWithFacebook>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialIcon(
                  icon_src: "assets/icons/facebookicon.svg",
                  press: (){
                    context.read<FireAuth>().signInWithFacebook(context);
                  },
                ),
              ],
            )

        )
    );
  }

}