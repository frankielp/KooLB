import 'package:koolb/place/place.dart';
import 'package:koolb/util/reservation.dart';

import 'package:koolb/user/koolUser.dart';

class Host extends KoolUser {
  //Constructor
  String country, language, currency;
  List<Place> listing;
  List<Reservation> reservation;

  //Function
  Host(super.name, super.password, super.email, this.country, this.language,
      this.currency, this.listing, this.reservation);
}
