import 'package:koolb/place/place.dart';
import 'package:koolb/util/reservation.dart';

class Host {
  //Constructor
  String name, email, fb;
  DateTime date;
  List<Place> listing;
  List<Reservation> reservation;

  //Function
  Host(this.name, this.email, this.fb, this.date, this.listing,
      this.reservation);
}
