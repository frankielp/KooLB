import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(const RenterMaps());

class RenterMaps extends StatefulWidget {
  const RenterMaps({super.key});

  @override
  State<RenterMaps> createState() => _RenterMapsState();
}

class _RenterMapsState extends State<RenterMaps> {
  late GoogleMapController mapController;

  // final LatLng _center = const LatLng(45.521563, -122.677433);
  // static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  // static const LatLng destinationLocation = LatLng(37.33429383, -122.06600055);

  late LatLng currentLocation;
  List<Marker> marker = [];
  Set<Marker> markers = new Set();

  void getCurrentLocation() async {
    geolocator.Position position =
        await geolocator.Geolocator.getCurrentPosition(
            desiredAccuracy: geolocator.LocationAccuracy.high);
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void getHotelLocation() {
    markers.add(const Marker(
      markerId: MarkerId("1"),
      position: LatLng(37.33500926, -122.03272188),
      infoWindow: InfoWindow(
        title: 'Hotel 1',
      ),
    ));
    markers.add(const Marker(
      markerId: MarkerId("2"),
      position: LatLng(27.7137735, 85.315626),
      infoWindow: InfoWindow(
        title: 'Hotel 2',
      ),
    ));
  }

  @override
  void initState() {
    getCurrentLocation();
    getHotelLocation();
    // marker.addAll(list);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: currentLocation == null
            ? const Center(child: Text('Loading'))
            : GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 20.5,
                ),
                markers: getmarkers()),
      ),
    );
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      getHotelLocation();

      markers.add(
        Marker(
          markerId: const MarkerId("currentLocation"),
          position: currentLocation,
          infoWindow: const InfoWindow(
            title: 'You are here',
          ),
        ),
      );
      //add more markers here
    });

    return markers;
  }
}
