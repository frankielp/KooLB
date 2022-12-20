import 'package:firebase_auth/firebase_auth.dart';

class KoolUser {
  String name, password, email;

  //Function
  KoolUser(this.name, this.password, this.email);
}

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;
  ChatUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}
