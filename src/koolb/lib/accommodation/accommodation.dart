import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/place/place.dart';
import '../user/host.dart';

class Accommodation extends Place {
  late String id;
  String description;
  List<Category> category;
  double price;
  late double rating;
  int room;
  int children;
  int guests;
  late List<DateTimeRange> bookedTime;
  late String link;

  Accommodation(
      {required this.description,
      required this.category,
      required this.price,
      required this.room,
      required this.children,
      required this.guests,
      GeoPoint? location,
      String? title})
      : super(title!, location!);

  //TODO: upload to firestore

  //TODO: up to firebase

  //TODO: get accommodation from database
}
