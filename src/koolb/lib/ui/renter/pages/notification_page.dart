// import 'dart:html';
import 'package:koolb/decoration/color.dart';
import 'package:flutter/material.dart';
import 'package:koolb/user/koolUser.dart';
import 'package:koolb/ui/renter/pages/chat/chat_page.dart';

class NotiPage extends StatefulWidget {
  const NotiPage({super.key});

  @override
  State<NotiPage> createState() => _NotiPageState();
}

class _NotiPageState extends State<NotiPage> {
  Map<String, String> Notification = {
    'Title': 'Top 10 hotels in Berlin',
    'BriefDescription': 'A trip through the scenery of Berlin'
  };
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
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(context,
                      //         MaterialPageRoute(builder: (context) {
                      //       return ChatPage();
                      //     }));
                      //   },
                      //   child: Icon(
                      //     Icons.forum,
                      //     color: Colors.black,
                      //     size: 20,
                      //   ),
                      // ),
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 20,
                      ),
                    ]),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "NOTIFICATION",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.cyan,
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            color: Colors.black,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListView.builder(
              //View list of notification
              itemCount: 1,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return NotiViewBuilder(
                  title: Notification['Title'].toString(),
                  briefDescrip: Notification['BriefDescrip'].toString(),
                  isRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NotiViewBuilder extends StatefulWidget {
  String title;
  String briefDescrip;
  bool isRead;
  NotiViewBuilder(
      {required this.title, required this.briefDescrip, required this.isRead});

  @override
  _NotiListState createState() => _NotiListState();
}

class _NotiListState extends State<NotiViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.briefDescrip,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
