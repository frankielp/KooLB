import 'dart:io';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

abstract class ParentPreview extends StatelessWidget {
  String title;
  String hostName;
  int numAdults;
  int numChildren;
  String description;
  String address;
  String city;
  String country;

  ParentPreview(
      {super.key,
      required this.title,
      required this.hostName,
      required this.numAdults,
      required this.numChildren,
      required this.description,
      required this.address,
      required this.city,
      required this.country});

  Widget accommodationImage(double height);

  Widget _defaultDivider() {
    return const Divider(
      color: Colors.black,
      thickness: 1.0,
    );
  }

  Widget titleText() {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
    );
  }

  Widget hostNameText() {
    return Text(
      'Hosted by $hostName',
      style: const TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.w300),
    );
  }

  Widget basicsText() {
    return Text(
      '$numAdults adults - $numChildren children',
      style: const TextStyle(color: Colors.black, fontSize: 17),
    );
  }

  Widget descriptionText() {
    return Text(
      description,
      style: const TextStyle(color: Colors.black, fontSize: 17),
    );
  }

  Widget locationText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w300),
        ),
        Text(
          '$address, $city, $country',
          style: const TextStyle(color: Colors.black, fontSize: 17),
        ),
      ],
    );
  }

  Widget main(double imageHeight) {
    return Dismissible(
      key: const Key('key'),
      direction: DismissDirection.down,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            accommodationImage(imageHeight),
            titleText(),
            _defaultDivider(),
            hostNameText(),
            _defaultDivider(),
            basicsText(),
            _defaultDivider(),
            descriptionText(),
            _defaultDivider(),
            locationText(),
          ],
        ),
      ),
    );
  }
}

class PreviewForMobile extends ParentPreview {
  File image;

  PreviewForMobile(
      {super.key,
      required this.image,
      required super.title,
      required super.hostName,
      required super.numAdults,
      required super.numChildren,
      required super.description,
      required super.address,
      required super.city,
      required super.country});

  @override
  Widget accommodationImage(double height) {
    return SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: super.main(MediaQuery.of(context).size.height / 2),
    );
  }
}

// class 