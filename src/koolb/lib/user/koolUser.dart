import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class KoolUser {
  String name, email;
  String? id;
  String authID;

  static final _userCollection = FirebaseFirestore.instance.collection('user');
  static final _chatCollection = FirebaseFirestore.instance.collection('chat');

  //Function
  KoolUser(
      {required this.name, required this.email, this.id, required this.authID});

  static Future<String> addUserToFirebase({
    required String name,
    required String email,
    required String authID,
  }) async {
    final ref = await _userCollection.add({
      'name': name,
      'email': email,
      'authID': authID,
      'chat': [],
    });

    final userID = ref.id;
    final userRef = _userCollection.doc(userID);
    userRef.update({
      'id': userID,
    });
    return userID;
  }

  static getUserSnapshot(String userId) async {
    return _userCollection.doc(userId).snapshots();
  }

  Future<String> createNewChat(String otherId) async {
    String chatId = '${id}_$otherId';
    _chatCollection.doc(chatId).set({
      'user1': id,
      'user2': otherId,
    }).catchError((e) {
      print(e.toString());
    });

    return chatId;
  }

  static KoolUser fromMap(Map<String, dynamic> data) {
    return KoolUser(
        name: data['name'],
        email: data['email'],
        id: data['id'],
        authID: data['authID']);
  }

  static getUserById(String id) async {
    return _userCollection.doc(id).get();
  }
}
