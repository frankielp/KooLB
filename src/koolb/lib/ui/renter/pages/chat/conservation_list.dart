import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:koolb/chat/chat.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/chat/message_tile.dart';

class ConversationList extends StatefulWidget {
  final String chatId;
  final String currentUserId;
  final String otherUserId;
  final String otherUserName;
  const ConversationList({
    super.key,
    required this.chatId,
    required this.currentUserId,
    required this.otherUserId,
    required this.otherUserName,
  });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  Stream<QuerySnapshot>? _chats;

  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.otherUserName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade800,
      ),
      body: Stack(
        children: [
          // chat message
          _chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade800,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Send a message',
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      _sendMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: BlueJean,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _getChat() {
    Chat.getCurrentChat(widget.chatId).then((val) {
      setState(() {
        _chats = val;
      });
    });
  }

  _chatMessages() {
    return StreamBuilder(
      stream: _chats,
      builder: (context, AsyncSnapshot snapshot) {
        debugPrint('chatData has data: ${snapshot.hasData}');
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  debugPrint('${snapshot.data.docs[index]['sender']}');
                  debugPrint(widget.currentUserId);
                  return MessageTile(
                    message: snapshot.data.docs[index]['message'],
                    sendByMe: snapshot.data.docs[index]['sender'] ==
                        widget.currentUserId,
                  );
                },
              )
            : Container();
      },
    );
  }

  _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        'message': _messageController.text,
        'sender': widget.currentUserId,
        'time': DateTime.now(),
      };

      Chat.sendMessage(widget.chatId, chatMessageMap);
      setState(() {
        _messageController.clear();
      });
    }
  }
}
