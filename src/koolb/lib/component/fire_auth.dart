import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:koolb/component/showSnackBar.dart';

class FireAuth {
  final FirebaseAuth _auth;
  FireAuth(this._auth);

  // GET USER DATA
  // This method should be called only when the user is logged in
  // So, this is the authentication user
  User get user => _auth.currentUser!;

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      // await user!.updateProfile(displayName: name);
      await user!.updateDisplayName(name);
      await user.updateEmail(email);
      await user.updatePassword(password);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  // FACEBOOK SIGN IN
  Future<User?> signInWithFacebook(BuildContext context) async{
    User? user;
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login();
      
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
      user = this.user;
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }

    print("User ID ${user?.uid}");
    return user;
  }
}
