import 'package:flutter/material.dart';

import '../decoration/color.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: Row(
        children: const <Widget>[
          BuildDivider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: BlueJean,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          BuildDivider(),
        ],
      ),
    );
  }
}

class BuildDivider extends StatelessWidget {
  const BuildDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}