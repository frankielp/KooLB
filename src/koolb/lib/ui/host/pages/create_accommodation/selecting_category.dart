import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SelectingCategory extends StatefulWidget {
  const SelectingCategory({super.key});

  @override
  State<SelectingCategory> createState() => _SelectingCategoryState();
}

class _SelectingCategoryState extends State<SelectingCategory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose category'),
    );
  }
}
