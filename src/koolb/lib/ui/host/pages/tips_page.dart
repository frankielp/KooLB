// CLASS OF A TIP
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:readmore/readmore.dart';

import '../../../decoration/color.dart';

class TipsModel {
  late String tipName;
  late String tipContent;
  late bool isExpanded;

  TipsModel.fromSnapshot(snapshot) {
    tipName = snapshot.data()['tipName'];
    tipContent = snapshot.data()['tipContent'];
    isExpanded = true;
  }
}

// DISPLAY TOP TITLE
Widget CustomTopBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.only(top: 70.0, right: 130.0),
    height: 170,
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      gradient: LinearGradient(
          colors: [Turquois, BlueJean],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
    ),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 5.0),
            child: Text(
              'Hosting tips',
              style: TextStyle(
                  fontSize: 45,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.0, left: 8.0, bottom: 15.0),
            child: Text(
              'Hosting is not difficult!',
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          )
        ]),
  );
}

// GET DATA
Future<List<TipsModel>?> readData() async {
  List<TipsModel> tips = [];
  var data = await FirebaseFirestore.instance
      .collection('tip')
      .orderBy('timing', descending: true)
      .get();
  tips = List.from(data.docs.map((doc) => TipsModel.fromSnapshot(doc)));
  // tips[0].isExpanded = true;

  return tips;
}

// DISPLAY LIST OF TIPS
Widget TipsList(BuildContext context) {
  quill.QuillController _controller = quill.QuillController.basic();
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding:
        const EdgeInsets.only(left: 8.0, top: 15.0, right: 8.0, bottom: 14.0),
    child: FutureBuilder(
      future: readData(),
      builder: (context, data) {
        if (data.hasError) {
          return Center(
            child: Text("${data.error}"),
          );
        } else if (data.hasData) {
          var tips = data.data as List<TipsModel>;
          return ListView.separated(
              itemBuilder: (context, index) {
                // return ListTile(
                //   title: SingleChildScrollView(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           tips[index].tipName.toString(),
                //           style: TextStyle(
                //               color: BlueJean,
                //               fontSize: 30,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 10.0),
                //           child: ReadMoreText(
                //             tips[index]
                //                 .tipContent
                //                 .toString()
                //                 .replaceAll("\\n", "\n"),
                //             style: TextStyle(
                //               fontSize: 15,
                //             ),
                //             trimLines: 3,
                //             trimMode: TrimMode.Line,
                //             trimCollapsedText: " Show More",
                //             trimExpandedText: " Show Less ",
                //             lessStyle: TextStyle(color: Turquois),
                //             moreStyle: TextStyle(color: Turquois),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );
                var myJSON = jsonDecode(tips[index].tipContent);
                _controller = quill.QuillController(
                  document: quill.Document.fromJson(myJSON),
                  selection: TextSelection.collapsed(offset: 0),
                );
                return ExpansionTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tips[index].tipName.toString(),
                        style: TextStyle(
                            color: BlueJean,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  children: [
                    SizedBox(height: size.height * 0.03),
                    SizedBox(
                      child: Container(
                        color: Colors.grey[100],
                        padding: const EdgeInsets.all(8),
                        child: quill.QuillEditor.basic(
                          controller: _controller,
                          readOnly: true, // true for view only mode
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (BuildContext content, int index) =>
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                  ),
              itemCount: tips.length);
        } else {
          return Container();
        }
      },
    ),
  );
}

// TIPS PAGE
class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TipsPage();
  }
}

class _TipsPage extends State<TipsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomTopBar(context),
          Expanded(
            child: TipsList(context),
          ),
        ],
      ),
    );
  }
}
