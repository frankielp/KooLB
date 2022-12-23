import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingBasics extends StatefulWidget {
  const SettingBasics({super.key});

  @override
  State<SettingBasics> createState() => _SettingBasicsState();
}

class _SettingBasicsState extends State<SettingBasics> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose category'),
    );
  }
}
