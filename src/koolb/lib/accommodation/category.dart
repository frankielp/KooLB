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
