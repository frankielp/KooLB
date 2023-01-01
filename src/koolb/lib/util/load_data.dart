import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:koolb/data/countries_and_cities.dart';
import 'package:location/location.dart';

List<String> countries = <String>[];

void loadData() {
  countries = getCountries();
  countriesAndCities = getCities();
}

List<String> getCountries() {
  var res = <String>[];

  countriesAndCities.forEach((key, value) {
    res.add(key);
  });

  return res;
}

// get list of countries and their cities
Map<String, List<String>> getCities() {
  var map = countriesAndCities;
  Map data = map;

  var res = data.map((key, value) =>
      MapEntry<String, List<String>>(key, List<String>.from(value)));
  return res;
}

//get geoPoint by address
Future<GeoPoint> getGeoPointByAddress(String address) async {
  try {
    var locations = await locationFromAddress(address);
    if (locations.isEmpty) {
      throw "Not found address.";
    }
    var location = locations[0];
    return GeoPoint(location.latitude, location.longitude);
  } catch (e) {
    print(e);
  }
  return GeoPoint(0, 0);
}
