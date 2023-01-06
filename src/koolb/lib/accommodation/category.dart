enum Category {
  SharedHome,
  Apartment,
  Hostel,
  Hotel,
  Homestay,
  BreakfastIncluded,
  Spa,
  Pool,
  AirConditioning,
  ParkingLot,
  DoubleRoom,
  NearCity,
  HighSafety,
}

List<Category> intArrayToListCategory(List<int> a) {
  List<Category> ret = [];
  a.forEach((element) {
    ret.add(Category.values[element]);
  });
  return ret;
}

extension ParseToString on Category {
  String toShortString() {
    if (this == Category.SharedHome) {
      return "Shared Home";
    } else if (this == Category.BreakfastIncluded) {
      return "Breakfast Included";
    } else if (this == Category.ParkingLot) {
      return "Parking Lot";
    } else if (this == Category.AirConditioning) {
      return "Air Conditioning";
    } else if (this == Category.DoubleRoom) {
      return "Double Room";
    } else if (this == Category.HighSafety) {
      return "High Safety";
    } else if (this == Category.NearCity) {
      return "Near City";
    } else
      return this.toString().split('.').last;
  }
}
