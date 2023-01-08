import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:koolb/decoration/color.dart';

class AccommodationTileHost extends StatefulWidget {
  final String accommodationId;
  const AccommodationTileHost({super.key, required this.accommodationId});

  @override
  State<AccommodationTileHost> createState() => _AccommodationTileHostState();
}

class _AccommodationTileHostState extends State<AccommodationTileHost> {
  static final _accommodationCollection =
      FirebaseFirestore.instance.collection('accommodation');

  String? imagePath;
  String? country;
  String? city;
  double? rating;
  String? name;
  double? price;

  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: null,
        child: Column(
          children: [
            FutureBuilder(
              future: _getAccommodation(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  imagePath = data['imagePath'];
                  country = data['country'];
                  city = data['city'];
                  rating = data['rating'] * 1.0;
                  name = data['name'];
                  price = data['price'] * 1.0;
                  return _listTile();
                } else {
                  return _loadingWidget();
                }
              },
            ),
            _defaultDivider(),
          ],
        ),
      ),
    );
  }

  _loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: BlueJean,
      ),
    );
  }

  _defaultDivider() {
    return const Divider(
      thickness: 0.5,
      color: Colors.black,
    );
  }

  _listTile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageContainer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _countryAndCity(),
            _rating(),
          ],
        ),
        _nameContainer(),
        const SizedBox(
          height: 5,
        ),
        _priceContainer(),
      ],
    );
  }

  _imageContainer() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: FutureBuilder(
        future: _downloadUrl(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  snapshot.data!,
                  width: size.width * 0.75,
                  height: size.width * 0.75,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            return SizedBox(
              width: size.width * 0.8,
              height: size.width * 0.8,
              child: const CircularProgressIndicator(
                color: BlueJean,
              ),
            );
          }
        },
      ),
    );
  }

  _countryAndCity() {
    return Text(
      '${country}, ${city}',
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
        color: Color.fromARGB(255, 111, 110, 110),
        fontSize: 15,
      ),
    );
  }

  Future<String> _downloadUrl() async {
    String downloadUrl = await FirebaseStorage.instance
        .ref('accommodationImages/${widget.accommodationId}.png')
        .getDownloadURL();

    return downloadUrl;
  }

  _rating() {
    return Row(
      children: [
        Text(
          ((rating! * 10).toInt() / 10).toDouble().toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: DarkBlue,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        const Icon(
          Icons.star,
          size: 13,
        ),
      ],
    );
  }

  _nameContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(
        name!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: DarkBlue,
          fontSize: 15,
        ),
      ),
    );
  }

  _priceContainer() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          const TextSpan(
            text: 'Price: ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: '${'\$${(price! * 10).toInt() / 10.0}'} / night',
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  _getAccommodation() {
    return _accommodationCollection.doc(widget.accommodationId).get();
  }
}
