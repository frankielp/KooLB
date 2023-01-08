import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/data/global_data.dart';

class Accommodation extends Place {
  static final CollectionReference _accommodationCollection =
      FirebaseFirestore.instance.collection('accommodation');

  late String id;
  String address;
  String country;
  String city;
  String description;
  List<Category> category;
  double price;
  late double rating;
  int room;
  int children;
  int guests;
  late List<DateTime> starts;
  late List<DateTime> ends;
  late String imageLink;

  Accommodation({
    required String title,
    required this.description,
    required this.address,
    required this.city,
    required this.country,
    required GeoPoint location,
    required this.category,
    required this.price,
    required this.room,
    required this.children,
    required this.guests,
    required this.rating,
    required this.starts,
    required this.ends,
  }) : super(title, location);

  get location => super.position;

  static Future<String> addAccommodationToFirebaseWeb(
      {required String title,
      required String description,
      required double price,
      required String address,
      required String city,
      required String country,
      required List<Category> categories,
      required Uint8List webImage,
      required int rooms,
      required int adults,
      required int children,
      GeoPoint? location,
      required String userId,
      required String hostId}) async {
    // location ??= await getGeoPointByAddress(address);

    final accommodationCollection =
        FirebaseFirestore.instance.collection('accommodation');

    List<int> type = [];
    for (var element in categories) {
      type.add(element.index);
    }

    final accommodationRef = await accommodationCollection.add({
      'name': title,
      'description': description,
      'price': price,
      'room': rooms,
      'children': children,
      'adult': adults,
      'address': address,
      'city': city,
      'country': country,
      'rating': 5,
      'starts': [],
      'ends': [],
      'location': const GeoPoint(0, 0),
      'imagePath': '',
      'hostId': hostId,
      'userId': userId,
      'hostName': name,
      'category': FieldValue.arrayUnion(type),
    });

    String accommodationID = accommodationRef.id;

    _updateAccommodation(
        accommodationID, _addImageToFirebaseForWeb(accommodationID, webImage));

    return accommodationID;
  }

  static Future<String> addAccommodationToFirebaseMobile(
      {required String title,
      required String description,
      required double price,
      required String address,
      required String city,
      required String country,
      required List<Category> categories,
      required File mobileImage,
      required int rooms,
      required int adults,
      required int children,
      required String hostId,
      required String userId,
      GeoPoint? location}) async {
    // location ??= await getGeoPointByAddress(address);

    final accommodationCollection =
        FirebaseFirestore.instance.collection('accommodation');

    List<int> type = [];
    for (var element in categories) {
      type.add(element.index);
    }

    final accommodationRef = await accommodationCollection.add({
      'name': title,
      'description': description,
      'price': price,
      'room': rooms,
      'children': children,
      'adult': adults,
      'address': address,
      'city': city,
      'country': country,
      'rating': 5,
      'starts': [],
      'ends': [],
      'location': const GeoPoint(0, 0),
      'imagePath': '',
      'hostId': hostId,
      'userId': userId,
      'hostName': name,
      'category': FieldValue.arrayUnion(type),
    });

    String accommodationID = accommodationRef.id;

    _updateAccommodation(accommodationID,
        _addImageToFirebaseForMobile(accommodationID, mobileImage));

    return accommodationID;
  }

  /*get image of accommodation: 
    1. get reference of firebase storage
    2. all the images of accommodations are in 'accommodationImages' -> get reference of 'accommodationImages'
    3. the image of accommodation will be name as '<accommodationID>.jpg' -> get reference of that file.
  */
  static String _addImageToFirebaseForWeb(String id, Uint8List webImages) {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('accommodationImages');
    Reference referenceDirImageAccommodation =
        referenceDirImage.child('$id.png');

    referenceDirImageAccommodation.putData(webImages);

    return referenceDirImageAccommodation.fullPath;
  }

  static String _addImageToFirebaseForMobile(String id, File mobileImage) {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('accommodationImages');
    Reference referenceDirImageAccommodation =
        referenceDirImage.child('$id.png');

    referenceDirImageAccommodation.putFile(mobileImage);

    return referenceDirImageAccommodation.fullPath;
  }

  static void _updateAccommodation(String id, String imagePath) {
    final accommodationRef =
        FirebaseFirestore.instance.collection('accommodation').doc(id);
    accommodationRef.update({
      'id': id,
      'imagePath': imagePath,
    });
  }

  static Future getAccommodationByIdFuture(String accommodationId) {
    return _accommodationCollection.doc(accommodationId).get();
  }

  static Future<List<Accommodation>> getAccommodationBasedOnDatabase(
      String country,
      String city,
      int numRooms,
      int numAdult,
      int numChildren,
      DateTime start,
      DateTime end) async {
    List<Accommodation> ret = [];
    QuerySnapshot qn = await FirebaseFirestore.instance
        .collection('accommodation')
        .where('country', isEqualTo: country)
        .where('city', isEqualTo: city)
        .get();

    qn.docs.forEach((element) {
      final map = element.data();
      if (element['room'] < numRooms ||
          element['adult'] < numAdult ||
          element['children'] < numChildren) {
        return;
      }
      List<DateTime> starts = [];
      element['starts'].forEach((value) {
        starts.add(value.toDate());
      });
      List<DateTime> ends = [];
      element['ends'].forEach((value) {
        ends.add(value.toDate());
      });
      for (int i = 0; i < starts.length; ++i) {
        if ((start.isAfter(starts[i]) && start.isAfter(ends[i]) ||
            (end.isAfter(starts[i]) && end.isBefore(ends[i])))) {
          return;
        }
      }
      List<Category> category = [];
      element['category'].forEach((value) {
        category.add(Category.values[value]);
      });
      ret.add(Accommodation(
          category: category,
          price: element['price'],
          rating: element['rating'],
          room: element['room'],
          children: element['children'],
          guests: element['adult'],
          title: element['name'],
          starts: starts,
          ends: ends,
          country: element['country'],
          city: element['city'],
          location: element['location'],
          address: element['address'],
          description: element['description']));
    });

    print(ret);
    return ret;
  }
}
