import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddingPhoto extends StatefulWidget {
  const AddingPhoto({super.key});

  @override
  State<AddingPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddingPhoto> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Choose category'),
    );
  }
}
