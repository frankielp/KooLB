import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Chat {
  static final CollectionReference _chatCollection =
      FirebaseFirestore.instance.collection('chat');
  static final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('user');

  static Stream<DocumentSnapshot> getChatStream(String chatId) {
    return _chatCollection.doc(chatId).snapshots();
  }

  static getChatFuture(String chatId) async {
    return _chatCollection.doc(chatId).get();
  }

  static Future<String> newChat(String user1Id, String user2Id) async {
    await _chatCollection
        .where('user1', isEqualTo: user1Id)
        .where('user2', isEqualTo: user2Id)
        .get()
        .then((QuerySnapshot value) {
      if (value.size > 0) {
        final ref = value.docs.first;
        return ref.id;
      }
    });

    await _chatCollection
        .where('user1', isEqualTo: user2Id)
        .where('user2', isEqualTo: user1Id)
        .get()
        .then((QuerySnapshot value) {
      if (value.size > 0) {
        final ref = value.docs.first;
        return ref.id;
      }
    });
    
    final newChatRef = await _chatCollection.add({
      'id': '',
      'recentMessage': '',
      'recentMessageSender': '',
      'user1': user1Id,
      'user2': user2Id,
    });

    final newChatId = newChatRef.id;

    _userCollection.doc(user1Id).update({
      'chat': FieldValue.arrayUnion([newChatId]),
    });

    _userCollection.doc(user2Id).update({
      'chat': FieldValue.arrayUnion([newChatId]),
    });

    newChatRef.update({
      'id': newChatId,
    });

    return newChatId;
  }

  static _fromJsonToMap(Map<String, dynamic> json) {
    return json;
  }

  static getCurrentChat(String chatId) async {
    return _chatCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  static sendMessage(
      String chatId, Map<String, dynamic> chatMessageData) async {
    _chatCollection.doc(chatId).collection('messages').add(chatMessageData);
    _chatCollection.doc(chatId).update({
      'recentMessage': chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      'recentTime': chatMessageData['time'],
    });
  }
}
