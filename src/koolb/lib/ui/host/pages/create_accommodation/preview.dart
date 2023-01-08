import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class ParentPreview extends StatelessWidget {
  String title;
  String hostName;
  int numAdults;
  int numChildren;
  String description;
  String address;
  String city;
  String country;
  double price;

  ParentPreview(
      {super.key,
      required this.title,
      required this.hostName,
      required this.numAdults,
      required this.numChildren,
      required this.description,
      required this.address,
      required this.city,
      required this.country,
      required this.price});

  Widget accommodationImage(double height);
  onDismissible(DismissDirection direction);

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
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget hostNameText() {
    return Text(
      'Hosted by $hostName',
      style: const TextStyle(
          color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
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
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        Text(
          '$address, $city, $country',
          style: const TextStyle(color: Colors.black, fontSize: 17),
        ),
      ],
    );
  }

  Widget _priceText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w700),
        ),
        Text(
          '${price}\$ night',
          style: const TextStyle(color: Colors.black, fontSize: 17),
        ),
      ],
    );
  }

  Widget main(double imageHeight) {
    return Dismissible(
      key: const Key('key'),
      direction: DismissDirection.down,
      onDismissed: ((direction) {
        onDismissible(direction);
      }),
      child: SingleChildScrollView(
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
              _priceText(),
              _defaultDivider(),
              locationText(),
            ],
          ),
        ),
      ),
    );
  }
}

class PreviewForMobile extends ParentPreview {
  File image;
  late BuildContext _context;

  PreviewForMobile({
    super.key,
    required this.image,
    required super.title,
    required super.hostName,
    required super.numAdults,
    required super.numChildren,
    required super.description,
    required super.address,
    required super.city,
    required super.country,
    required super.price,
  });
  @override
  Widget accommodationImage(double height) {
    return Center(
      child: SizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Image.file(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Accommodation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: super.main(MediaQuery.of(context).size.height / 2),
      ),
    );
  }

  @override
  onDismissible(DismissDirection direction) {
    switch (direction) {
      case DismissDirection.down:
        Navigator.pop(_context);
        break;
      default:
    }
  }
}

// preview for web
class PreviewForWeb extends ParentPreview {
  Uint8List image;
  late BuildContext _context;

  PreviewForWeb({
    super.key,
    required this.image,
    required super.title,
    required super.hostName,
    required super.numAdults,
    required super.numChildren,
    required super.description,
    required super.address,
    required super.city,
    required super.country,
    required super.price,
  });

  @override
  Widget accommodationImage(double height) {
    return Center(
      child: SizedBox(
        height: height,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          child: Image.memory(
            image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview Accommodation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: super.main(MediaQuery.of(context).size.height / 2),
      ),
    );
  }

  @override
  onDismissible(DismissDirection direction) {
    switch (direction) {
      case DismissDirection.down:
        Navigator.pop(_context);
        break;
      default:
    }
  }
}
