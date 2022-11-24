import 'package:flutter/material.dart';
import 'package:koolb/component/text_field_container.dart';

import '../decoration/color.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: LightBlue,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}