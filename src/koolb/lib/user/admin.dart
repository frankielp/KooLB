import 'package:firebase_auth/firebase_auth.dart';
import 'package:koolb/user/koolUser.dart';

class Admin extends KoolUser {
  Admin() : super(name: FirebaseAuth.instance.currentUser!.displayName!, email: FirebaseAuth.instance.currentUser!.email!, authID: FirebaseAuth.instance.currentUser!.uid);
}
