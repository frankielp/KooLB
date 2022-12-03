import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/place/place.dart';
import 'package:koolb/util/helper.dart';
import '../host/host.dart';

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

  double get price => _price;

  double get rating => _rating;

  int get room => _room;

  int get children => _children;

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
}
