import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koolb/accommodation/accommodation.dart';

class Booking {
  String renterID;
  String accommodationID;
  int numAdults;
  int numChildren;
  DateTime checkinDate;
  DateTime checkoutDate;

  Booking(
      {required this.renterID,
      required this.accommodationID,
      required this.checkinDate,
      required this.checkoutDate,
      this.numAdults = 1,
      this.numChildren = 0});

  //TODO add book to firebase
  Future<void> addInfoToFirebase() {
    // List<String> stringStart = [];
    // _starts.forEach((element) {
    //   stringStart.add(dateTimeToString(element));
    // });
    // List<String> stringEnd = [];
    // _ends.forEach((element) {
    //   stringEnd.add(dateTimeToString(element));
    // });
    return FirebaseFirestore.instance
        .collection('booking')
        .add(<String, dynamic>{
          'renterId': renterID,
          'accommodationId': accommodationID,
          'checkinDate': checkinDate,
          'checkoutDate': checkoutDate,
          'numChildren': numChildren,
          'numAdults': numAdults,
        })
        .then((value) => print('Booking Added'))
        .catchError((error) => print('Error $error'));
  }

  // check the validity of booking time
  static bool checkValidBooking(
      Accommodation accommodation, DateTime start, DateTime end) {
    int n = accommodation.starts.length;
    for (int i = 0; i < n; ++i) {
      var aStart = accommodation.starts[i];
      var aEnd = accommodation.ends[i];

      if ((aStart.isBefore(start) && aEnd.isAfter(start)) ||
          (aStart.isBefore(end) && aEnd.isAfter(end))) {
        return false;
      }
    }
    return true;
  }
}
