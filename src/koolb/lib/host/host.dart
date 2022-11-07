import 'package:koolb/place/place.dart';
import 'package:koolb/util/reservation.dart';

class Host {
  //Constructor
  String name, email, fb;
  String password, country, language, currency;
  DateTime DOB;
  DateTime date;
  List<Place> listing;
  List<Reservation> reservation;

  //Function
  Host(this.name, this.email, this.fb, this.password, this.country, this.DOB,
      this.language, this.currency, this.date, this.listing, this.reservation);
}
