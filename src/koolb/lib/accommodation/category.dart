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
    }
    if (this == Category.BreakfastIncluded) {
      return "Breakfast Included";
    }
    else return this.toString().split('.').last;
  }
}
