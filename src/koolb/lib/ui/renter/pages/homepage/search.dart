//import 'dart:html';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/decoration/color.dart';
import 'package:koolb/util/helper.dart';
import 'package:koolb/util/load_data.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late LocationData? _currentPosition;
  Location location = new Location();
  String? countryValue;
  String? cityValue;
  List<String> cities = <String>[];
  bool countrySelected = false;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  Color dateButtonColor = BlueJean;
  static const defaultDivider = Divider(
    thickness: 0.5,
    color: cyan,
  );
  final TextEditingController _numRooms = TextEditingController();
  final TextEditingController _numAdults = TextEditingController();
  final TextEditingController _numChildren = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //safe screen
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              // location
              _customDefaultDecoratedContainer(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Where to go?',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    defaultDivider,
                    Row(
                      children: [
                        //Country dropdown
                        Expanded(
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                            ),
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select a Country",
                                labelText: "Country",
                              ),
                            ),
                            selectedItem: countryValue,
                            items: countries,
                            onChanged: ((String? value) {
                              setState(() {
                                cities = countriesAndCities[value]!;
                                cityValue = null;
                                countrySelected = true;
                                countryValue = value!;
                                print(
                                    "Selected country: $countryValue\nCountry selected: $countrySelected\nCities: $cities");
                              });
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Expanded(
                          child: DropdownSearch<String>(
                            popupProps: const PopupProps.menu(
                              showSearchBox: true,
                              showSelectedItems: true,
                            ),
                            selectedItem: cityValue,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                hintText: "Select a Cty",
                                labelText: "City",
                              ),
                            ),
                            items: cities,
                            onChanged: ((String? value) {
                              setState(() {
                                cityValue = value!;
                              });
                            }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              //when
              _customDefaultDecoratedContainer(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You are here',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  defaultDivider,
                  Row(
                    children: [
                      const Text('From'),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: dateButtonColor),
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 5));
                          if (picked != null && picked != start) {
                            setState(() {
                              start = picked;
                              if (start.isAfter(end)) {
                                end = start;
                              }
                            });
                          }
                        },
                        child: Text(dateTimeToString(start)),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      const Text('to'),
                      const SizedBox(
                        width: 15.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: dateButtonColor),
                        onPressed: () async {
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year),
                            lastDate: DateTime(DateTime.now().year + 5),
                          );
                          if (picked != null && picked != end) {
                            end = picked;
                            setState(() {
                              if (end.isAfter(start)) {
                                dateButtonColor = BlueJean;
                              } else {
                                dateButtonColor = actionColor;
                                const snackBar = SnackBar(
                                  content: Text(
                                      'The end day must be after the start day!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            });
                          }
                        },
                        child: Text(dateTimeToString(end)),
                      )
                    ],
                  )
                ],
              )),
              //room
              _customDefaultDecoratedContainer(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You need',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  defaultDivider,
                  const SizedBox(
                    height: 0.5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: _numRooms,
                          maxLength: 6,
                          textInputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          validator: (value) {
                            return _validator(value, 1);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text('rooms'),
                    ],
                  )
                ],
              )),
              //Adult
              _customDefaultDecoratedContainer(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'You have',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  defaultDivider,
                  const SizedBox(
                    height: 0.5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                            controller: _numAdults,
                            maxLength: 6,
                            textInputAction: TextInputAction.next,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            validator: (value) {
                              return _validator(value, 1);
                            }),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text('adults'),
                    ],
                  )
                ],
              )),
              //children
              _customDefaultDecoratedContainer(Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'And you go with',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(
                    height: 0.5,
                  ),
                  defaultDivider,
                  const SizedBox(
                    height: 0.5,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          maxLength: 6,
                          controller: _numChildren,
                          textInputAction: TextInputAction.next,
                          keyboardType: const TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          validator: (value) {
                            return _validator(value, 0);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text('children'),
                    ],
                  )
                ],
              )),
              //search
              ElevatedButton(
                child: const Text('Search'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final snackBar = SnackBar(
                        content: Text(
                            'Num rooms: $_numRooms.text, num adults: $_numAdults.text, num children: $_numChildren.text'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _validator(String? value, int minValue) {
    if (value == null || value.isEmpty) {
      return 'You must fill this.';
    }
    final n = num.parse(value);
    if (n is double || n is Float) {
      return 'The number must be an integer';
    }
    if (n < minValue) {
      return 'The number must be greater than $minValue.';
    }
    return null;
  }

  Container _customDefaultDecoratedContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: cyan),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
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
    } else if (sortByDistance && _currentPosition != null) {
      accommodations.sort((a, b) => Geolocator.distanceBetween(
              a.location.latitude,
              a.location.longitude,
              _currentPosition!.latitude!,
              _currentPosition!.longitude!)
          .compareTo(Geolocator.distanceBetween(
              b.location.latitude,
              b.location.longitude,
              _currentPosition!.latitude!,
              _currentPosition!.longitude!)));
    }
    accommodation = accommodations.toSet();
    return accommodation;
  }

  fetchLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentPosition = currentLocation;
      });
    });
  }
}
