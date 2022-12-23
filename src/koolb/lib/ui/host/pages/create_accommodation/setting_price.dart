import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SettingPrice extends StatefulWidget {
  const SettingPrice({super.key});

  @override
  State<SettingPrice> createState() => _SettingPriceState();
}

class _SettingPriceState extends State<SettingPrice> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose category'),
    );
  }
}
