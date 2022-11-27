import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
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
  String countryValue = "";
  String cityValue = "";
  String stateValue = "";
  String address = "";
  @override
  Widget build(BuildContext context) {
    //safe screen
    return Column(
      children: <Widget>[
        // location
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //text
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('Where to go?'),
            ),
            //choose location
            SelectState(
              onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },
              onStateChanged: (value) {
                setState(() {
                  stateValue = value;
                });
              },
              onCityChanged: (value) {
                setState(() {
                  cityValue = value;
                });
              },
            ),

            ///print newly selected country state and city in Text Widget
            TextButton(
                onPressed: () {
                  setState(() {
                    address = "$cityValue, $countryValue";
                  });
                },
                child: Text("Print Data")),
            Text(address)
          ],
        ),
      ],
    );
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
