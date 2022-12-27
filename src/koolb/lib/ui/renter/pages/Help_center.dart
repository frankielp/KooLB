import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});
  @override
  State<HelpCenter> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenter> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.cyan,
                Colors.cyanAccent,
                Colors.lightGreenAccent,
              ])),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HELP CENTER',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 25,
                    ),
                    Icon(
                      Icons.wifi_calling_sharp,
                      color: Colors.black45,
                      size: 28,
                    )
                  ],
                ),
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                        image:
                            ExactAssetImage('assets/images/call_center.png')),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Hotline: (+84) 985 876 378',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                  ),
                  subtitle: Text(
                    'In case you need any urgent help, please contact to us via this mobile phone',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.2,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Email: lpnquynh20@apcs.fitus.edu.vn',
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.5,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Or if you are willing to find some frequent questions, please make yourself to the FAQ section for further information. Thank you.',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
