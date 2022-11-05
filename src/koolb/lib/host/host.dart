import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/util/reservation.dart';

class Host {
  //Constructor
  String name, email, fb, dob, country, currency, language;

  //Function
  Host(this.name, this.email, this.fb, this.dob, this.country, this.currency,
      this.language);
  /*
  add information of host to firebase
  */
  Future<void> addInfoToFirebase() {
    return FirebaseFirestore.instance
        .collection('host')
        .add(<String, dynamic>{
          'name': name,
          'email': email,
          'fb': fb,
          'DOB': dob,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Fail $error'));
  }
}
