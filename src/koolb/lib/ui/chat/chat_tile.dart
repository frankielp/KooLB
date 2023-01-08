import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/chat/chat.dart';
import 'package:koolb/main.dart';
import 'package:koolb/ui/chat/conservation_list.dart';
import 'package:koolb/user/koolUser.dart';
import 'package:koolb/util/helper.dart';

class ChatTile extends StatefulWidget {
  final String userId;
  final String chatId;
  const ChatTile({
    super.key,
    required this.userId,
    required this.chatId,
  });

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');
  static final CollectionReference _chatCollection =
      FirebaseFirestore.instance.collection('chat');

  String? _otherUserId;
  String? _recentSender;

  @override
  void initState() {
    super.initState();
    // _loadChatInfo();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _chatCollection.doc(widget.chatId).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        debugPrint(widget.chatId);
        debugPrint('${snapshot.hasData}');
        debugPrint('${snapshot.data}');
        if (snapshot.hasData && snapshot.data?.data() != null) {
          final chatData = snapshot.data?.data() as Map<String, dynamic>;
          debugPrint(chatData.toString());
          _otherUserId = chatData['user1'] == widget.userId
              ? chatData['user2']
              : chatData['user1'];
          String recentMessage = chatData['recentMessage'];
          String recentSender = chatData['recentMessageSender'];
          Timestamp dataTime = chatData['recentTime'];
          DateTime timeSend = DateTime.fromMillisecondsSinceEpoch(
              dataTime.millisecondsSinceEpoch);
          if (_otherUserId == null) {
            return _loadingWidget();
          }
          return FutureBuilder(
            future: _userCollection.doc(_otherUserId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data?.data() as Map<String, dynamic>;
                debugPrint(userData.toString());
                debugPrint('name: ${userData['name']}');
                debugPrint('id: ${userData['id']}');
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationList(
                          chatId: widget.chatId,
                          currentUserId: widget.userId,
                          otherUserId: _otherUserId!,
                          otherUserName: userData['name'],
                        ),
                      ),
                    );
                  },
                  //profile
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blue.shade800,
                    child: Text(userData['name'][0]),
                  ),
                  title: Text(
                    userData['name'],
                    style: TextStyle(fontSize: 20, fontWeight: _fontWeight()),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${recentSender == widget.userId ? 'You' : userData['name']}: $recentMessage',
                          style: TextStyle(
                              fontSize: 15, fontWeight: _fontWeight()),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(dateTimeToString(timeSend, format: 'hh:mm, MMM dd')),
                    ],
                  ),
                );
              } else {
                return _loadingWidget();
              }
            },
          );
        } else {
          return _loadingWidget();
        }
      },
    );
  }

  _loadingWidget() {
    return const ListTile(
      leading: Icon(
        Icons.account_circle_rounded,
        size: 20,
      ),
    );
  }

  _fontWeight() {
    return _otherUserId == _recentSender ? FontWeight.bold : FontWeight.w300;
  }
}
