import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/feature/reservation.dart';
import 'package:koolb/place/place.dart';
import 'package:koolb/user/koolUser.dart';

class Renter extends KoolUser {

  //Constructor
  String _country, _language, _currency, _profileImg;
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
      String? name,
      String? email,
      String? id)
      : _profileImg = profileImg,
        _country = country,
        _language = language,
        _currency = currency,
        _listing = listing,
        _accommodation = accommodation,
        super(name, email, id);
  String get profileImg => _profileImg;
  String get country => _country;
  String get language => _language;
  String get currency => _currency;
  List<Place> get listing => _listing;
  List<Accommodation> get accommodation => _accommodation;
}
