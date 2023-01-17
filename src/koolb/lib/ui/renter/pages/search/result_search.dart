import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/ui/renter/pages/search/filter_page.dart';
import 'package:location/location.dart';

class ResultSearch extends StatefulWidget {
  final List<Accommodation> resultSearch;
  const ResultSearch({super.key, required this.resultSearch});

  @override
  State<ResultSearch> createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  late List<Category> requirement = [];
  double rating = 3;
  double budget = 100000000;
  late List<Accommodation> show = List.from(widget.resultSearch);

  Location location = Location();
  late LocationData _currentPosition;
  Sort sort = Sort.price;

  @override
  void initState() {
    // fetchLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: show.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final item = show[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Name: ${item.name}'),
                      Text('Price: ${item.price}'),
                      Text('Rating: ${item.rating}'),
                    ],
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              _getDataFromFilter();
            },
            child: Text('Filter'),
          ),
        ],
      ),
    );
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

  void _getDataFromFilter() async {
    print('Before\n');
    widget.resultSearch.forEach((element) {
      print(element.name);
    });
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FilterPage(
                  listCategory: requirement,
                  listAccommodation: List.from(widget.resultSearch),
                  rating: rating,
                  budget: budget,
                  sortBy: sort,
                  currentPosition: _currentPosition,
                )));
    setState(() {
      requirement = result['category'];
      show = result['accommodation'];
      rating = result['rating'];
      budget = result['budget'];
      sort = result['sortBy'];
    });
    print('After\n');
    show.forEach((element) {
      print(element.name);
    });
  }
}

enum Sort { price, rating, distance }
