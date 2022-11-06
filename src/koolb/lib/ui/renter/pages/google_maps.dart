import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    getCurrentLocation();
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
                markers: {
                  Marker(
                    markerId: const MarkerId("currentLocation"),
                    position: currentLocation,
                  ),
                },
              ),
      ),
    );
  }
}
