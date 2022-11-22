import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../decoration/color.dart';

class SocialIcon extends StatelessWidget {
  final String icon_src;
  final VoidCallback press;
  const SocialIcon({
    Key? key,
    required this.icon_src,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          icon_src,
          height: 30,
          width: 30,
          color: BlueJean,
        ),
      ),
    );
  }
}
