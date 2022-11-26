import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

Set<Accommodation> filterResult(Set<Accommodation> accommodation,
    List<Category.Category> requirement, double rating, double budget) {
  accommodation.retainWhere((element) =>
      filterRequirement(element, requirement, rating, budget) == true);
  return accommodation;
}

bool filterRequirement(Accommodation accommodation,
    List<Category.Category> requirement, double rating, double budget) {
  for (Category.Category categories in requirement) {
    if (!accommodation.category.contains(categories)) return false;
  }
  if (accommodation.rating < rating) return false;
  if (accommodation.price > budget) return false;
  return true;
}

Set<Accommodation> sortAccommodation(Set<Accommodation> accommodation,
    bool sortByPrice, bool sortByRating, bool sortByDistance) {
  // GeoPoint currentLocation;
  List<Accommodation> accommodations = accommodation.toList();
  if (sortByPrice) {
    accommodations.sort((a, b) => a.price.compareTo(b.price));
  } else if (sortByRating) {
    accommodations.sort((a, b) => a.rating.compareTo(b.rating));
  } 
  // else if (sortByDistance) {
  //   accommodations.sort((a, b) => Geolocator.distanceBetween(
  //           a.location.latitude,
  //           a.location.longitude,
  //           currentLocation.latitude,
  //           currentLocation.latitude)
  //       .compareTo(Geolocator.distanceBetween(
  //           b.location.latitude,
  //           b.location.longitude,
  //           currentLocation.latitude,
  //           currentLocation.latitude)));
  // }
  accommodation = accommodations.toSet();
  return accommodation;
}
