import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectingAmenities extends StatefulWidget {
  const SelectingAmenities({super.key});

  @override
  State<SelectingAmenities> createState() => _SelectingAmenitiesState();
}

class _SelectingAmenitiesState extends State<SelectingAmenities> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose category'),
    );
  }
}
