import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/place/place.dart';
import '../user/host.dart';

class Accommodation extends Place {
  List<Category> _category;
  double _price;
  double _rating;
  int _room;
  int _children;
  List<DateTimeRange> _bookedTime;

  Accommodation(
      List<Category> category,
      double price,
      double rating,
      int room,
      int children,
      List<DateTimeRange> bookedTime,
      String name,
      GeoPoint location)
      : _category = category,
        _price = price,
        _rating = rating,
        _room = room,
        _children = children,
        _bookedTime = bookedTime,
        super(name, location);

  List<Category> get category => _category;

  double get price => _price;

  double get rating => _rating;

  int get room => _room;

  int get children => _children;

  List<DateTimeRange> get bookedTime => _bookedTime;

  GeoPoint get location => super.position;
}
