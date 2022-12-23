import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingTitleDescription extends StatefulWidget {
  const SettingTitleDescription({super.key});

  @override
  State<SettingTitleDescription> createState() =>
      _SettingTitleDescriptionState();
}

class _SettingTitleDescriptionState extends State<SettingTitleDescription> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose category'),
    );
  }
}
