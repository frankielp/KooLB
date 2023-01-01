import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart' as Category;
//import 'package:koolb/component/category_item.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/wishlist/wishlist.dart';

import '../../../decoration/widget.dart';
import '../../../main.dart';

const renterID = 'HgvSKaOM6uSLK9qrH2ZL';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String title});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> favoriteAccommodationIDs = [];

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    getUserFavoriteListIDs();
  }

  Future getUserFavoriteListIDs() async {
    List<String> tmp = [];
    var data = await FirebaseFirestore.instance
          .collection('wishlist')
          .doc(renter.wishlistID)
          .get();

    List<WishlistFolder> folders = List.from(data.data()?['folders'].map((doc) => WishlistFolder.fromSnapshot(doc)));

    for (int i = 0; i < folders.length; ++i){
      tmp = List.from(tmp)..addAll(folders[i].accommodationIDs);
    }
    setState(() {
      favoriteAccommodationIDs = tmp;
      //print(favoriteAccommodationIDs);
    });
  }

  List<String> categories = [
    "All",
    "Apartment",
    "Shared Home",
    "Hostel",
    "Hotel",
    "Homestay"
  ];

  List<String> icons = [
    "icons/all.png",
    "icons/apartment.png",
    "icons/sharedhouse.png",
    "icons/hostel.png",
    "icons/hotel.png",
    "icons/homestay.png"
  ];

  List<String> images = [
    "https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
    "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
    "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
    "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",
  ];

  List<Accommodation> accommodations = [
    Accommodation(
        [Category.Category.Hotel],
        ["https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",],
        0.5,
        4.5,
        1,
        1,
        1,
        [DateTime(2022, 12, 1, 0, 0), DateTime(2023, 1, 1, 0, 0)],
        [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
        'Việt Nam',
        'An Giang',
        'a1',
        GeoPoint(16.456661, 107.5960929)),
    Accommodation(
        [Category.Category.Hotel],
        ["https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",],
        0.5,
        4.5,
        1,
        1,
        1,
        [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
        [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
        'Việt Nam',
        'An Giang',
        'a2',
        GeoPoint(16.456661, 107.5960929)),
    Accommodation(
        [Category.Category.Hotel],
        ["https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",],
        0.5,
        4.5,
        1,
        1,
        1,
        [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
        [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
        'Việt Nam',
        'An Giang',
        'a2',
        GeoPoint(16.456661, 107.5960929)),
    Accommodation(
        [Category.Category.Hotel],
        ["https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",],
        0.5,
        4.5,
        1,
        1,
        1,
        [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
        [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
        'Việt Nam',
        'An Giang',
        'a2',
        GeoPoint(16.456661, 107.5960929)),
    Accommodation(
        [Category.Category.Hotel],
        ["https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",],
        0.5,
        4.5,
        1,
        1,
        1,
        [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
        [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
        'Việt Nam',
        'An Giang',
        'a2',
        GeoPoint(16.456661, 107.5960929)),
    Accommodation(
        [Category.Category.Hotel],
        ["https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
          "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",],
        0.5,
        4.5,
        1,
        1,
        1,
        [DateTime(2022, 12, 12, 0, 0), DateTime(2023, 1, 12, 0, 0)],
        [DateTime(2022, 12, 14, 0, 0), DateTime(2023, 1, 14, 0, 0)],
        'Việt Nam',
        'An Giang',
        'a2',
        GeoPoint(16.456661, 107.5960929))
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.25,
                  decoration: const BoxDecoration(
                    color: LightBlue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(55),
                        bottomRight: Radius.circular(85)),
                  ),
                ),
                Container(
                  height: size.height * 0.25,
                  decoration: const BoxDecoration(
                    color: BlueJean,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(85),
                        bottomRight: Radius.circular(65)),
                  ),
                ),
                Container(
                  height: size.height * 0.23,
                  decoration: const BoxDecoration(
                    color: LightBlue2,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(70),
                        bottomRight: Radius.circular(70)),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.1,
                        vertical: size.height * 0.02),
                    child: Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Find your best\ndestination",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: BlueJean,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 35,
                              width: size.width * 0.6,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(vertical: 15),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(29.5)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Text(
                                      "Where to?",
                                      style: TextStyle(
                                        color: LightBlue,
                                      ),
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.08,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              alignment: Alignment.center,
                              height: 35,
                              width: size.width * 0.1,
                              decoration: const BoxDecoration(
                                color: Colors.white60,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: BlueJean,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 0, top: size.height * 0.03),
              child: listCategories(),
            ),
            // listAccommodation(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: listAccommodation(favoriteAccommodationIDs),
            ),
          ],
        ),
      ),
    );
  }

  Set<Accommodation> filterResult(
      Set<Accommodation> accommodation, List<Category.Category> requirement) {
    accommodation.retainWhere(
            (element) => filterRequirement(element, requirement) == true);
    return accommodation;
  }

  bool filterRequirement(
      Accommodation accommodation, List<Category.Category> requirement) {
    for (Category.Category categories in requirement) {
      if (!accommodation.category.contains(categories)) return false;
    }
    return true;
  }

  int selectedCategory = 0;

  listCategories() {
    List<Widget> lists = List.generate(
        categories.length,
            (index) => CategoryItem(
          //icon: icons[index],
          data: categories[index],
          selected: index == selectedCategory,
          onTap: () {
            setState(() {
              selectedCategory = index;
            });
          },
        ));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: lists),
    );
  }

  listAccommodation(List<String> favoriteAccommodationIDs) {
    Size size = MediaQuery.of(context).size;
    List<Accommodation> filteredaccommodations = accommodations;
    //print(List.from(accommodations.map((e) => e.id)));
    filteredaccommodations = displayByCategory(filteredaccommodations);
    List<Widget> lists = List.generate(
        filteredaccommodations.length,
            (index) => AccommodationItem(
          isFavorite: favoriteAccommodationIDs.contains(filteredaccommodations[index].id),
          data: filteredaccommodations[index],
          //image: images,
          onTap: () {
            setState(() {});
          },
        ));
    return Container(
      height: size.height * 0.52,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: Column(
          children: lists,
        ),
      ),
    );
  }

  List<Accommodation> displayByCategory(List<Accommodation> filteredaccommodations) {
    switch(selectedCategory) {
      case 1: {
        filteredaccommodations = filterResult(accommodations.toSet(), [Category.Category.Apartment]).toList();
      }
      break;
      case 2: {
        filteredaccommodations = filterResult(accommodations.toSet(), [Category.Category.SharedHome]).toList();
      }
      break;
      case 3: {
        filteredaccommodations = filterResult(accommodations.toSet(), [Category.Category.Hostel]).toList();
      }
      break;
      case 4: {
        filteredaccommodations = filterResult(accommodations.toSet(), [Category.Category.Hotel]).toList();
      }
      break;
      case 5: {
        filteredaccommodations = filterResult(accommodations.toSet(), [Category.Category.Homestay]).toList();
      }
      break;
      default:
        break;
    }

    return filteredaccommodations;
  }
}
