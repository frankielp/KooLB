import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
<<<<<<< HEAD
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/util/load_data.dart';

class Accommodation extends Place {
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
  late List<DateTimeRange> bookedTime;
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

  get location => null;
=======
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/place/place.dart';

class Accommodation extends Place {
  List<Category.Category> _category;
  double _price;
  double _rating;
  int _room;
  int _children;
  int _adult;
  List<DateTime> _starts;
  List<DateTime> _ends;
  String _country;
  String _city;

  Accommodation(
      List<Category.Category> category,
      double price,
      double rating,
      int room,
      int children,
      int adult,
      List<DateTime> starts,
      List<DateTime> ends,
      String country,
      String city,
      String name,
      GeoPoint location)
      : _category = category,
        _price = price,
        _rating = rating,
        _room = room,
        _children = children,
        _adult = adult,
        _starts = starts,
        _ends = ends,
        _country = country,
        _city = city,
        super(name, location);

  List<Category.Category> get category => _category;
>>>>>>> main

  //TODO: upload to firestore

  //TODO: up to firebase
  static Future<void> addAccommodationToFirebaseWeb(
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

<<<<<<< HEAD
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
  }

  static Future<void> addAccommodationToFirebaseMobile(
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
=======
  int get adult => _adult;

  List<DateTime> get starts => _starts;

  List<DateTime> get ends => _ends;

  String get country => _country;

  String get city => _city;

  GeoPoint get location => super.position;

  /*
  add information of accommodation to firebase
  */
  Future<void> addInfoToDatabase() {
    // List<String> stringStart = [];
    // _starts.forEach((element) {
    //   stringStart.add(dateTimeToString(element));
    // });
    // List<String> stringEnd = [];
    // _ends.forEach((element) {
    //   stringEnd.add(dateTimeToString(element));
    // });
    List<int> type = [];
    category.forEach((element) {
      type.add(element.index);
    });
    return FirebaseFirestore.instance
        .collection('accommodation')
        .add(<String, dynamic>{
          'category': FieldValue.arrayUnion(type),
          'price': _price,
          'rating': _rating,
          'room': _room,
          'children': _children,
          'adult': _adult,
          'country': _country,
          'city': _city,
          'starts': FieldValue.arrayUnion(_starts),
          'ends': FieldValue.arrayUnion(_ends),
          'name': name,
          'location': location,
        })
        .then((value) => print('Accommodation Added'))
        .catchError((error) => print('Error $error'));
  }

  Map<String, dynamic> toJson() {
    List<int> type = [];
    category.forEach((element) {
      type.add(element.index);
    });
    return {
      'category': FieldValue.arrayUnion(type),
      'price': _price,
      'rating': _rating,
      'room': _room,
      'children': _children,
      'adult': _adult,
      'country': _country,
      'city': _city,
      'starts': FieldValue.arrayUnion(_starts),
      'ends': FieldValue.arrayUnion(_ends),
      'name': name,
      'location': location,
    };
  }

  static Accommodation fromJson(Map<String, dynamic> json) {
    List<Category.Category> category =
        Category.intArrayToListCategory(json['category']);
    List<DateTime> starts =
        json['starts'].forEach((value) => value.toDate()).toList();

    List<DateTime> ends =
        json['ends'].forEach((value) => value.toDate()).toList();

    return Accommodation(
        Category.intArrayToListCategory(json['category']),
        json['price'],
        json['rating'],
        json['room'],
        json['children'],
        json['adult'],
        starts,
        ends,
        json['country'],
        json['city'],
        json['name'],
        json['location']);
  }

  static Future<List<Accommodation>> getAccommodationBasedOnDatabase(
      String country,
      String city,
      int numRooms,
      int numAdult,
      int numChildren,
      DateTime start,
      DateTime end) async {
    List<Accommodation> ret = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('accommodation')
        .where('country', isEqualTo: country)
        .where('city', isEqualTo: city)
        .get();

    qn.docs.forEach((element) {
      final map = element.data();
      if (element['room'] < numRooms ||
          element['adult'] < numAdult ||
          element['children'] < numChildren) {
        return;
      }
      List<DateTime> starts = [];
      element['starts'].forEach((value) {
        starts.add(value.toDate());
      });
      List<DateTime> ends = [];
      element['ends'].forEach((value) {
        ends.add(value.toDate());
      });
      for (int i = 0; i < starts.length; ++i) {
        if ((start.isAfter(starts[i]) && start.isAfter(ends[i]) ||
            (end.isAfter(starts[i]) && end.isBefore(ends[i])))) {
          return;
        }
      }
      List<Category.Category> category = [];
      element['category'].forEach((value) {
        category.add(Category.Category.values[value]);
      });
      ret.add(Accommodation(
          category,
          element['price'],
          element['rating'],
          element['room'],
          element['children'],
          element['adult'],
          starts,
          ends,
          element['country'],
          element['city'],
          element['name'],
          element['location']));
    });

    print(ret);
    return ret;
  }

  static Future<List<Accommodation>> getAllAccommodation() async {
    List<Accommodation> ret = [];
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('accommodation').get();

    qn.docs.forEach((element) {
      final map = element.data();
      List<DateTime> starts = [];
      element['starts'].forEach((value) {
        starts.add(value.toDate());
      });
      List<DateTime> ends = [];
      element['ends'].forEach((value) {
        ends.add(value.toDate());
      });
      List<Category.Category> category = [];
      element['category'].forEach((value) {
        category.add(Category.Category.values[value]);
      });
      ret.add(Accommodation(
          category,
          element['price'],
          element['rating'],
          element['room'],
          element['children'],
          element['adult'],
          starts,
          ends,
          element['country'],
          element['city'],
          element['name'],
          element['location']));
    });

    print(ret);
    return ret;
  }

  static Future<Accommodation> getAccommodationById(uid) async {
    var snapshot = await FirebaseFirestore.instance
        .collection('accommodation')
        .doc(uid)
        .get();
    if (snapshot.exists) {
      throw Exception('Accommodation does not exist in database');
    }

    Map<String, dynamic>? data = snapshot.data();
    List<DateTime> starts = [];
    data?['starts'].forEach((value) {
      starts.add(value.toDate());
    });
    List<DateTime> ends = [];
    data?['ends'].forEach((value) {
      ends.add(value.toDate());
    });
    List<Category.Category> category = [];
    data?['category'].forEach((value) {
      category.add(Category.Category.values[value]);
    });
    double price = data?['price'];
    double rating = data?['rating'];
    int room = data?['room'];
    int children = data?['children'];
    int adult = data?['adults'];
    String country = data?['country'];
    String city = data?['city'];
    String name = data?['name'];
    GeoPoint location = data?['location'];

    return Accommodation(category, price, rating, room, children, adult, starts,
        ends, country, city, name, location);
>>>>>>> main
  }
}
