import 'package:flutter/material.dart';
import 'package:about/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:pubspec/pubspec.dart';

class AboutUs extends StatefulWidget {
  @override
  State<AboutUs> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "ABOUT US",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              title: Text('About KOOLB'),
              subtitle: Text(
                  'KOOLB was founded on a belief that travellers can find their most comfortable stay-over when reaching the destinations for various purposes.  Lauched with the same couragous sprit we bring to all our adventures, we embarked all this journeys with a clear set of objective: to offer the hishest quality accomodation at an unparalleled while helping to nurture our growing community of travellers and tourists. We are all caring at heart, are we not? There is much to be gained from travelling and seeing the world, feeling the difference between each culture through the style of their housing style. We should all embrace at least a little wanderlust. When you equip yourself for adventure, you are bound to find some - so heed the call, and get our there!'),
            ),
            ListTile(
              title: Text('Our Team Developer'),
              subtitle: Text(
                  'Our developer team consist of five members:\nLe Pham Nhat Quynh\nTruong Thuy Tuong Vy\nNguyen Ha Ngoc Linh\nBui Le Gia Cat\nLe Gia Khanh'),
            ),
            ListTile(
              title: Text('Our Mission'),
              subtitle: Text(
                  'Our team is from group 01 of APCS20, and this is our project from the course Elements of Software Engineering (Course ID: CS300). We hope to bring you an experience more than just simply booking an accomodation.'),
            ),
          ],
        ),
      ),
    );
  }
}
