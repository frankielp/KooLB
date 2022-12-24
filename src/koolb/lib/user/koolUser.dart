import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

class KoolUser {
  String? name, email, id;

  //Function
  KoolUser(String? name, String? email, String? id) {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    this.name = firebaseUser?.displayName;
    this.email = firebaseUser?.email;
    this.id = firebaseUser?.uid;
  }
}
