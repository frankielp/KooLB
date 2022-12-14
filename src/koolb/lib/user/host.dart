import 'package:firebase_auth/firebase_auth.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/feature/reservation.dart';

import 'package:koolb/user/koolUser.dart';

class Host extends KoolUser {
  //Constructor
  String _country, _language, _currency;
  late List<Place> _listing;
  late List<Accommodation> _accommodation;

  //Function

  Host(
    String country,
    String language,
    String currency,
    List<Place> listing,
    List<Accommodation> accommodation,
  )   : _country = country,
        _language = language,
        _currency = currency,
        _listing = listing,
        _accommodation = accommodation,
        super(
            name: FirebaseAuth.instance.currentUser!.displayName!,
            email: FirebaseAuth.instance.currentUser!.email!,
            authID: FirebaseAuth.instance.currentUser!.uid);

  String get country => _country;
  String get language => _language;
  String get currency => _currency;
  List<Place> get listing => _listing;
  List<Accommodation> get accommodation => _accommodation;
}
