import 'dart:async';
import 'dart:convert';

import 'package:koolb/data/countries_and_cities.dart';

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
