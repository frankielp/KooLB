import 'package:flutter/material.dart';
import 'package:koolb/user/renter.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Profile()],
      ),
    );
  }
}

Widget ProfileHeader() {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      color: Colors.white,
      height: 80.0,
      width: 50.0,
    ),
    CircleAvatar(
        radius: 35.0,
        backgroundColor: Colors.black,
        backgroundImage: NetworkImage(''),
        child: Text('Frankie')),
    Container(
      color: Colors.white,
      height: 80.0,
      width: 50.0,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            color: Colors.black,
            height: 40.0,
            width: 200.0,
            child: Text(
              'Name',
              style: TextStyle(color: Colors.white),
            )),
        Container(
            alignment: Alignment.center,
            color: Colors.white,
            height: 40.0,
            width: 200.0,
            child: Text('Additional Info'))
      ],
    )
  ]);
}

Widget Profile() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: 40.0,
        width: 40.0,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    ],
  );
}
