import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectingLocation extends StatefulWidget {
  const SelectingLocation({super.key});

  @override
  State<SelectingLocation> createState() => _SelectingLocationState();
}

class _SelectingLocationState extends State<SelectingLocation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose Location'),
    );
  }
}
