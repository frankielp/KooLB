import 'package:flutter/material.dart';
import 'package:koolb/component/social_icon.dart';

class RowOfSocialIcons extends StatelessWidget {
  const RowOfSocialIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          icon_src: "assets/icons/facebookicon.svg",
          press: () {
            //CODE HERE
          },
        ),
        SocialIcon(
          icon_src: "assets/icons/googleicon.svg",
          press: () {
            //CODE HERE
          },
        ),
        SocialIcon(
          icon_src: "assets/icons/twittericon.svg",
          press: () {
            //CODE HERE
          },
        ),
      ],
    );
  }
}