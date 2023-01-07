import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/feature/reservation.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/user/koolUser.dart';

class Renter extends KoolUser {
  //Constructor
  String _country, _language, _currency, _profileImg;
  late String _id;
  late List<Place> _listing;
  late List<Accommodation> _accommodation;

  //Function
  Renter(
    String profileImg,
    String country,
    String language,
    String currency,
    List<Place> listing,
    List<Accommodation> accommodation,
  )   : _profileImg = profileImg,
        _country = country,
        _language = language,
        _currency = currency,
        _listing = listing,
        _accommodation = accommodation,
        super(
            name: FirebaseAuth.instance.currentUser!.displayName!,
            email: FirebaseAuth.instance.currentUser!.email!,
            authID: FirebaseAuth.instance.currentUser!.uid);
  String get profileImg => _profileImg;
  String get country => _country;
  String get language => _language;
  String get currency => _currency;
  List<Place> get listing => _listing;
  List<Accommodation> get accommodation => _accommodation;

  void addInformationToFirebase() async {}

  static addRenterToFirebase() async {}
}

Future<Map<String, String>> getRenterInfoById(id) async {
  var snapshot =
      await FirebaseFirestore.instance.collection('renter').doc(id).get();
  if (!snapshot.exists) {
    throw Exception('User does not exist in database');
  }
  Map<String, dynamic>? data = snapshot.data();

  String DOB = await data?['DOB'];
  String email = data?['email'];
  String fb = data?['fb'];
  String name = data?['name'];
  String username = data?['username'];
  return {
    'DOB': DOB,
    'email': email,
    'fb': fb,
    'name': name,
    'username': username
  };
}
