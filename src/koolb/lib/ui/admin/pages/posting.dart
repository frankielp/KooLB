import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koolb/decoration/color.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:koolb/ui/admin/ad_navigation_bar.dart';
import 'package:koolb/ui/renter/r_navigationbar.dart';

class PostingAdmin extends StatefulWidget {
  const PostingAdmin({super.key});

  @override
  State<PostingAdmin> createState() => _PostingAdminState();
}

class Posting {
  String _postHeading;
  String _postContent;
  DateTime _timing;

  Posting(postContent, postHeading, timing)
      : _postHeading = postHeading,
        _postContent = postContent,
        _timing = timing;

  Future<void> writeData() {
    return FirebaseFirestore.instance
        .collection('tip')
        .add(<String, dynamic>{
          'tipName': _postHeading,
          'tipContent': _postContent,
          'timing': _timing
        })
        .then((value) => print('Post Added'))
        .catchError((error) => print('Error $error'));
  }
}

class _PostingAdminState extends State<PostingAdmin> {
  String heading = '';
  final _controller = quill.QuillController.basic();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTopBar(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                const Text(
                  "Heading",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: BlueJean,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Heading',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: ((value) => setState(() => heading = value)),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                const Text(
                  "Content",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: BlueJean,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                quill.QuillToolbar.basic(
                  controller: _controller,
                  toolbarIconSize: 16,
                  iconTheme: quill.QuillIconTheme(
                    iconSelectedFillColor: BlueJean,
                    borderRadius: 12,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  child: Container(
                    color: Colors.grey[100],
                    padding: const EdgeInsets.all(16),
                    child: quill.QuillEditor.basic(
                      controller: _controller,
                      readOnly: false,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: buildSubmit(_controller),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSubmit(_controller) => Builder(
        builder: (context) => ButtonWidget(
          text: 'Post',
          onClicked: () {
            var content = jsonEncode(_controller.document.toDelta().toJson());
            Posting post = Posting(content, heading, DateTime.now());
            post.writeData();
            _showMyDialog(context);
          },
        ),
      );
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Your post has been posted successfully'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Now you can post another one!'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Approve'),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    // ProfilePage(user: user)),
                    AdminPagesNavigator(),
              ));
            },
          ),
        ],
      );
    },
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    required this.text,
    required this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          // shape: StadiumBorder(),
          backgroundColor: BlueJean,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: onClicked,
      );
}

Widget CustomTopBar(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
      gradient: LinearGradient(
          colors: [LightBlue2, BlueJean],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter),
    ),
    child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.1, vertical: size.width * 0.05),
        child: Text(
          'Posting',
          style: TextStyle(
              fontSize: 45, color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    ]),
  );
}
