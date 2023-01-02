import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

class KoolUser {
  String name, email;
  String? id;
  String authID;

  //Function
  KoolUser({required this.name, required this.email, this.id, required this.authID});

}
