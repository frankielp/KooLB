import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:koolb/place/place.dart';

// void main() => runApp(const RenterMaps());

class RenterMaps extends StatefulWidget {
  const RenterMaps({super.key});

  @override
  State<RenterMaps> createState() => _RenterMapsState();
}

class _RenterMapsState extends State<RenterMaps> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng currentLocation;
  Set<Marker> markers = new Set();

  final _collectionRef = FirebaseFirestore.instance.collection('place');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs;
    allData.forEach((document) {
      GeoPoint position = document.get('position');
      String name = document.get('name');
      markers.add(Marker(
        markerId: MarkerId(name),
        position: LatLng(position.latitude, position.longitude),
        infoWindow: InfoWindow(
          title: 'Hotel $name',
        ),
      ));
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = new Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    return await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder<LocationData?>(
        future: _currentLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat) {
          if (snapchat.hasData) {
            final LocationData currentLocation = snapchat.data;
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(currentLocation.latitude!,
                          currentLocation.longitude!),
                      zoom: 14.4746),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  markers: getmarkers(currentLocation),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  padding: const EdgeInsets.only(top: 40),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Set<Marker> getmarkers(LocationData currentLocation) {
    markers.add(
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
        infoWindow: const InfoWindow(
          title: 'You are here',
        ),
      ),
    );
    return markers;
  }
}
