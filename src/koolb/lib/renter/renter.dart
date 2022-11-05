import 'package:cloud_firestore/cloud_firestore.dart';

class Renter {
  // Constructor
  String name, username, email, fb, dob, country, currency, language;

  // String get name => _name;
  // set name(String name) {
  //   _name = name;
  // }

  // String get username => _username;
  // set username(String username) {
  //   _username = username;
  // }

  // String get email => _email;
  // set email(String email) {
  //   _email = email;
  // }

  // String get fb => _fb;
  // set fb(String fb) {
  //   _fb = fb;
  // }

  // String get name => _name;
  // set name(String name) {
  //   _name = name;
  // }

  //Function
  Renter(this.name, this.username, this.email, this.fb, this.dob, this.country,
      this.currency, this.language);

  /*
  add information of user to firebase
   */
  Future<void> addInfoToFirebase() {
    return FirebaseFirestore.instance
        .collection('renter')
        .add(<String, dynamic>{
          'name': name,
          'username': username,
          'email': email,
          'fb': fb,
          'DOB': dob,
        })
        .then((value) => print('Renter Added'))
        .catchError((error) => print('Fail $error'));
  }
}
