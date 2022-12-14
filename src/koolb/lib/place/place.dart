import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:koolb/user/host.dart';

class Place {
  //Contructor
  String _name;

  String get name => _name;

  set name(String name) {
    _name = name;
  }

//add kinh độ vĩ độ
  GeoPoint position;
  //Function
  Place(this._name, this.position, {Key? key});

  Future<void> addToFirebase() {
    return FirebaseFirestore.instance
        .collection('place')
        .add(<String, dynamic>{
          'name': name,
          'position': position,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Fail $error'));
  }
}