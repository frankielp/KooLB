import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/place/place.dart';
import '../host/host.dart';

class Accommodation extends Place {
  List<Category> _category;
  double _price;
  double _rating;
  int _room;
  int _children;
  int _adult;
  List<DateTimeRange> _bookedTime;
  String _country;
  String _city;

  Accommodation(
      List<Category> category,
      double price,
      double rating,
      int room,
      int children,
      int adult,
      List<DateTimeRange> bookedTime,
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
        _bookedTime = bookedTime,
        _country = country,
        _city = city,
        super(name, location);

  List<Category> get category => _category;

  double get price => _price;

  double get rating => _rating;

  int get room => _room;

  int get children => _children;

  int get adult => _adult;

  List<DateTimeRange> get bookedTime => _bookedTime;

  String get country => _country;

  String get city => _city;

  GeoPoint get location => super.position;
}
