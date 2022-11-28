import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:location/location.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late LocationData? _currentPosition;
  Location location = new Location();

  @override
  void initState() {
    fetchLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
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
