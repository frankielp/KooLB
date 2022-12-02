import 'package:flutter/cupertino.dart';
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
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(size),
          Profile(size),
          AccountSetting(size, context)
        ],
      ),
    );
  }
}

Widget ProfileHeader(Size size) {
  return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      color: Colors.white,
      height: size.height / 10,
      width: size.width * 0.15,
    ),
    CircleAvatar(
        radius: 35.0,
        backgroundColor: Colors.black,
        // backgroundImage: NetworkImage(''),
        child: Text('Frankie')),
    Container(
      color: Colors.white,
      height: size.height / 10,
      width: size.width * 0.15,
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.center,
            color: Colors.black,
            height: size.height / 20,
            width: size.width * 4 / 10,
            child: Text(
              'Name',
              style: TextStyle(color: Colors.white),
            )),
        Container(
            alignment: Alignment.center,
            color: Colors.white,
            height: size.height * 0.05,
            width: size.width * 0.4,
            child: Text('Additional Info'))
      ],
    )
  ]);
}

Widget Profile(Size size) {
  return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Padding(padding: EdgeInsets.all(size.width * 0.1)),
    Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.all(size.height * 0.03)),
        Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                color: Color.fromARGB(255, 13, 47, 108),
                height: size.height * 0.05,
                width: size.width * 0.1,
                child: Text('DOB', style: TextStyle(color: Colors.white))),
            Container(
                alignment: Alignment.centerRight,
                color: Color.fromARGB(255, 13, 47, 108),
                height: size.height * 0.05,
                width: size.width * 0.5,
                child: Text('DD/MM/YY', style: TextStyle(color: Colors.white)))
          ],
        ),
        Row(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                color: Color.fromARGB(255, 13, 47, 108),
                height: size.height * 0.05,
                width: size.width * 0.1,
                child: Text('Email', style: TextStyle(color: Colors.white))),
            Container(
                alignment: Alignment.centerRight,
                color: Color.fromARGB(255, 13, 47, 108),
                height: size.height * 0.05,
                width: size.width * 0.5,
                child: Text('example@gmail.com',
                    style: TextStyle(color: Colors.white)))
          ],
        ),
        Row(children: [
          Container(
              alignment: Alignment.centerLeft,
              color: Color.fromARGB(255, 13, 47, 108),
              height: size.height * 0.05,
              width: size.width * 0.2,
              child: Text('Facebook', style: TextStyle(color: Colors.white))),
          Container(
              alignment: Alignment.centerRight,
              color: Color.fromARGB(255, 13, 47, 108),
              height: size.height * 0.05,
              width: size.width * 0.4,
              child: Text('zz', style: TextStyle(color: Colors.white)))
        ]),
        Padding(padding: EdgeInsets.all(size.height * 0.03))
      ],
    )
  ]);
}

Widget AccountSetting(Size size, BuildContext context) {
  return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
    Padding(padding: EdgeInsets.all(size.width * 0.1)),
    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
          alignment: Alignment.center,
          color: Colors.white,
          height: size.height * 0.05,
          width: size.width * 0.6,
          child: Text('Setting', style: TextStyle(fontSize: 20))),
      Stack(
        children: [
          Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              height: size.height * 0.05,
              width: size.width * 0.6),
          TextButton(
              onPressed: () {},
              child: Text('User And Security', style: TextStyle(fontSize: 15)))
        ],
      ),
      Stack(
        children: [
          Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              height: size.height * 0.05,
              width: size.width * 0.6),
          TextButton(
              onPressed: () {},
              child: Text('General', style: TextStyle(fontSize: 15)))
        ],
      ),
      Stack(
        children: [
          Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              height: size.height * 0.05,
              width: size.width * 0.6),
          TextButton(
              onPressed: () {},
              child:
                  Text('Notification Setting', style: TextStyle(fontSize: 15)))
        ],
      ),
      Stack(
        children: [
          Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              height: size.height * 0.05,
              width: size.width * 0.6),
          TextButton(
              onPressed: () {},
              child: Text('About Us', style: TextStyle(fontSize: 15)))
        ],
      ),
      Stack(
        children: [
          Container(
              alignment: Alignment.center,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.blueAccent)),
              height: size.height * 0.05,
              width: size.width * 0.6),
          TextButton(
              onPressed: () {},
              child: Text('Help Center', style: TextStyle(fontSize: 15)))
        ],
      ),
      SizedBox(height: size.height * 0.1),
      ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(children: <Widget>[
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF0D47A1),
                      Color(0xFF1976D2),
                      Color(0xFF42A5F5),
                    ],
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {},
              child: const Text('Log Out'),
            ),
          ]))
    ])
  ]);
}

showConfirmLogout(context) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      message: Text("Would you like to log out?"),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {},
          child: Text(
            "Log Out",
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}
