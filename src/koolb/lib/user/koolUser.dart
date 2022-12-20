import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class KoolUser {
  String name, password, email;

  //Function
  KoolUser(this.name, this.password, this.email);
}

class ChatUsers {
  String name;
  String messageText;
  String time;
  ChatUsers(
      {required this.name, required this.messageText, required this.time});
}
