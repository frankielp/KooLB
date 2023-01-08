import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/accommodation_detail.dart';

class ListAccommodationTile extends StatefulWidget {
  final String name;
  final String description;
  final String address;
  final String imagePath;
  final double rating;
  final double price;
  final int room;
  final String accommodationID;
  final int guests;
  final int children;
  final String country;
  final String city;
  final List<Category> category;
  final String userId;
  final String hostName;
  bool isFavorite;
  ListAccommodationTile({
    super.key,
    required this.accommodationID,
    required this.imagePath,
    required this.country,
    required this.city,
    required this.address,
    required this.name,
    required this.description,
    required this.isFavorite,
    required this.price,
    required this.rating,
    required this.room,
    required this.guests,
    required this.children,
    required this.category,
    required this.userId,
    required this.hostName,
  });

  @override
  State<ListAccommodationTile> createState() => _ListAccommodationTileState();
}

class _ListAccommodationTileState extends State<ListAccommodationTile> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      child: InkWell(
        onTap: () {
          //TODO: go to detail page
          debugPrint('move to detail page');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        description: widget.description,
                        address: widget.address,
                        imagePath: widget.imagePath,
                        accommodationID: widget.accommodationID,
                        isFavorite: widget.isFavorite,
                        category: widget.category,
                        guests: widget.guests,
                        name: widget.name,
                        price: widget.price,
                        rating: widget.rating,
                        room: widget.room,
                        children: widget.children,
                        userId: widget.userId,
                        hostName: widget.hostName,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _listTile(),
              _defaultDivider(),
            ],
          ),
        ),
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
        Stack(
          children: [
            _imageContainer(),
            Positioned(
                right: 5,
                top: 5,
                child: HeartIcon(this.widget.accommodationID,
                    this.widget.isFavorite, this.widget.imagePath)),
          ],
        ),
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
    return FutureBuilder(
      future: _downloadUrl(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                snapshot.data!,
                width: size.width * 0.7,
                height: size.width * 0.7,
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
    );
  }

  _countryAndCity() {
    return Text(
      '${widget.country}, ${widget.city}',
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
        .ref('accommodationImages/${widget.accommodationID}.png')
        .getDownloadURL();

    return downloadUrl;
  }

  _rating() {
    return Row(
      children: [
        Text(
          ((widget.rating * 10).toInt() / 10).toDouble().toString(),
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
    return Text(
      widget.name,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: DarkBlue,
        fontSize: 15,
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
            text: '${'\$${(widget.price * 10).toInt() / 10.0}'} / night',
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
