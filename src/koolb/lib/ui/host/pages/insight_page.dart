import 'package:flutter/material.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => HostInsightPage();
}

class HostInsightPage extends State<InsightPage> {
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
                  Color.fromARGB(255, 54, 33, 161),
                  Color.fromARGB(255, 81, 87, 249),
                  Color.fromARGB(255, 152, 97, 220),
                ])),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('HOST INSIGHT',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.analytics_rounded,
                            color: Color.fromARGB(255, 255, 255, 255),
                            size: 30,
                          )
                        ],
                      ),
                    ]))),
      ),
    );
  }
}
