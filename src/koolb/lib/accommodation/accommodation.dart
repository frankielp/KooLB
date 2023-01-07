import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/util/load_data.dart';

class Accommodation extends Place {
  static final CollectionReference _accommodationCollection =
      FirebaseFirestore.instance.collection('accommodation');

  late String id;
  String address;
  String country;
  String city;
  String description;
  List<Category> category;
  double price;
  late double rating;
  int room;
  int children;
  int guests;
  late List<DateTime> starts;
  late List<DateTime> ends;
  late String imageLink;

  Accommodation({
    required String title,
    required this.description,
    required this.address,
    required this.city,
    required this.country,
    required GeoPoint location,
    required this.category,
    required this.price,
    required this.room,
    required this.children,
    required this.guests,
  }) : super(title, location);

  get location => super.position;

  //TODO: upload to firestore

  //TODO: up to firebase
  static Future<String> addAccommodationToFirebaseWeb(
      {required String title,
      required String description,
      required double price,
      required String address,
      required String city,
      required String country,
      required List<Category> categories,
      required Uint8List webImage,
      required int rooms,
      required int adults,
      required int children,
      GeoPoint? location}) async {
    location ??= await getGeoPointByAddress(address);

    final accommodationCollection =
        FirebaseFirestore.instance.collection('accommodation');

    List<int> type = [];
    for (var element in categories) {
      type.add(element.index);
    }

    final accommodationRef = await accommodationCollection.add({
      'name': title,
      'description': description,
      'price': price,
      'room': rooms,
      'children': children,
      'adult': adults,
      'address': address,
      'city': city,
      'country': country,
      'rating': 5,
      'starts': [],
      'ends': [],
      'location': location,
      'imagePath': '',
      'category': FieldValue.arrayUnion(type),
    });

    String accommodationID = accommodationRef.id;

    _updateAccommodation(
        accommodationID, _addImageToFirebaseForWeb(accommodationID, webImage));

    return accommodationID;
  }

  static Future<String> addAccommodationToFirebaseMobile(
      {required String title,
      required String description,
      required double price,
      required String address,
      required String city,
      required String country,
      required List<Category> categories,
      required File mobileImage,
      required int rooms,
      required int adults,
      required int children,
      GeoPoint? location}) async {
    location ??= await getGeoPointByAddress(address);

    final accommodationCollection =
        FirebaseFirestore.instance.collection('accommodations');

    List<int> type = [];
    for (var element in categories) {
      type.add(element.index);
    }

    final accommodationRef = await accommodationCollection.add({
      'name': title,
      'description': description,
      'price': price,
      'room': rooms,
      'children': children,
      'adult': adults,
      'address': address,
      'city': city,
      'country': country,
      'rating': 5,
      'starts': [],
      'ends': [],
      'location': location,
      'imagePath': '',
      'category': FieldValue.arrayUnion(type),
    });

    String accommodationID = accommodationRef.id;

    _updateAccommodation(accommodationID,
        _addImageToFirebaseForMobile(accommodationID, mobileImage));

    return accommodationID;
  }

  /*get image of accommodation: 
    1. get reference of firebase storage
    2. all the images of accommodations are in 'accommodationImages' -> get reference of 'accommodationImages'
    3. the image of accommodation will be name as '<accommodationID>.jpg' -> get reference of that file.
  */
  static String _addImageToFirebaseForWeb(String id, Uint8List webImages) {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('accommodationImages');
    Reference referenceDirImageAccommodation =
        referenceDirImage.child('$id.jpg');

    referenceDirImageAccommodation.putData(webImages);

    return referenceDirImageAccommodation.fullPath;
  }

  static String _addImageToFirebaseForMobile(String id, File mobileImage) {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('accommodationImages');
    Reference referenceDirImageAccommodation =
        referenceDirImage.child('$id.jpg');

    referenceDirImageAccommodation.putFile(mobileImage);

    return referenceDirImageAccommodation.fullPath;
  }

  //TODO: get accommodation from database

  //TODO: update accommodation
  static void _updateAccommodation(String id, String imagePath) {
    final accommodationRef =
        FirebaseFirestore.instance.collection('accommodation').doc(id);
    accommodationRef.update({
      'id': id,
      'imagePath': imagePath,
    });
  }

  static Future getAccommodationByIdFuture(String accommodationId) {
    return _accommodationCollection.doc(accommodationId).get();
  }
}
