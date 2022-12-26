import 'package:flutter/cupertino.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import '../../../../accommodation/accommodation.dart';

class WishListProvider extends ChangeNotifier{
  List<AccommodationItem> _accommodations = [];

  List<AccommodationItem> get accommodations => _accommodations;

  void toggleFavorite(AccommodationItem accommodation){
    final isExist = _accommodations.contains(accommodation);
    if (isExist){
      _accommodations.remove(accommodation);
    }
    else{
      _accommodations.add(accommodation);
    }
    notifyListeners();
  }

  void clearWishList(){
    _accommodations = [];
    notifyListeners();
  }
}