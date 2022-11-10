import 'package:koolb/place/place.dart';

class Reservation {
  //Constructor
  DateTime checkin;
  DateTime checkout;
  Place place;
  double price;
  int noOfGuest, noOfRoom;

  //Function
  Reservation(this.checkin, this.checkout, this.place, this.price,
      this.noOfGuest, this.noOfRoom);
}
