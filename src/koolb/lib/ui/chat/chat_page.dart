import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/decoration/color.dart';
import 'package:flutter/material.dart';
import 'package:koolb/ui/chat/chat_tile.dart';
import 'package:koolb/user/koolUser.dart';

class ChatPage extends StatefulWidget {
  String userName;
  String userID;
  ChatPage({super.key, required this.userName, required this.userID});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  static final _userCollection = FirebaseFirestore.instance.collection('user');
  static final _chatCollection = FirebaseFirestore.instance.collection('chat');

  Stream? _userChatList;

  @override
  void initState() {
    super.initState();
    _getChatList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Chat',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _chatList(),
    );
  }

  Future<Map<String, dynamic>> _nextScreen(Widget nextPage) async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => nextPage));
    return result;
  }

  _chatList() {
    return StreamBuilder(
      stream: _userChatList,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          debugPrint(snapshot.data['chat'].toString());
          if (snapshot.data['chat'] != null &&
              snapshot.data['chat'].length > 0) {
            return ListView.builder(
              itemCount: snapshot.data['chat'].length,
              itemBuilder: (context, index) {
                return ChatTile(
                  userId: widget.userID,
                  chatId: snapshot.data['chat'][index],
                );
              },
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
            );
          } else {
            return _noChatWidget();
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: BlueJean,
            ),
          );
        }
      },
    );
  }

  _noChatWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: [
            const Text(
              'Wow, such empty!',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            Image.asset('assets/images/empty.png'),
          ],
        ),
      ),
    );
  }

  _getChatList() async {
    await KoolUser.getUserSnapshot(widget.userID).then((snapshot) {
      setState(() {
        _userChatList = snapshot;
      });
    });
  }
}
