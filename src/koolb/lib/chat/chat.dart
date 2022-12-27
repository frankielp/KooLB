import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:koolb/firebase_options.dart';
// import 'package:koolb/ui/renter/pages/chat_page.dart';

const thisUserID = 'eNZEIQKDI4chp7eUcWufFqDYbj92';
const thatUserID = 'eNZEIQKDI4chp7eUcWufFqDYbj92';

class Chat {
  String _userId;
  Map<String, Map<Timestamp, List<String>>>
      _conversationList; //thatUserID ,[chat,]

  Chat(
      String userId, Map<String, Map<Timestamp, List<String>>> conversationList)
      : _userId = userId,
        _conversationList = conversationList;

  String get userId => _userId;
  Map<String, Map<Timestamp, List<String>>> get conversationList =>
      _conversationList;

  // static Future<Chat> getTotalChatById(id) async {
  // static Future<Chat> getTotalChatById(id) async {
  // var conversation = await FirebaseFirestore.instance
  //     .collection('chat_tree')
  //     .doc(id)
  //     .get();
  // if (conversation.exists) {
  //   throw Exception('Conversation does not exist in database');
  // }

  // Map<String, Map<Timestamp, List<String>>> chat;
  // Map<String, dynamic>? data = conversation.data();
  // return Chat(id,chat)

}
