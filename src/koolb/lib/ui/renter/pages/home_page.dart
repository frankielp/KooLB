import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart' as accommodation;
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/component/category_item.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/accommodation_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = [
    "All",
    "Apartment",
    "Shared Home",
    "Hostel",
    "Hotel",
    "Homestay"
  ];

  List<String> icons = [
    "assets/icons/all.png",
    "assets/icons/apartment.png",
    "assets/icons/sharedhouse.png",
    "assets/icons/hostel.png",
    "assets/icons/hotel.png",
    "assets/icons/homestay.png"
  ];

  List<String> images = [
    "https://pbs.twimg.com/media/FhrWVV6aAAAQvkf?format=jpg&name=large",
    "https://pbs.twimg.com/media/FiE26JbacAAVWQq?format=jpg&name=large",
    "https://pbs.twimg.com/media/FiE27l3aEAA2wTZ?format=jpg&name=large",
    "https://pbs.twimg.com/media/FiE27mragAIblmC?format=jpg&name=large",
  ];

  List<accommodation.Accommodation> accommodations = [
    accommodation.Accommodation(
      category: <Category.Category>[
        Category.Category.Hotel,
        Category.Category.BreakfastIncluded
      ],
      price: 0.5,
      guests: 1,
      children: 1,
      room: 1,
      country: 'Việt Nam',
      city: 'An Giang',
      title: 'a1',
      location: GeoPoint(16.456661, 107.5960929),
      address: 'address 1',
      description: 'description 1',
    ),
    accommodation.Accommodation(
        category: [Category.Category.Hotel],
        price: 0.5,
        guests: 1,
        children: 1,
        room: 1,
        country: 'Việt Nam',
        city: 'An Giang',
        title: 'a2',
        location: GeoPoint(16.456661, 107.5960929),
        address: 'address 2',
        description: 'description 2'),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Wrap(
        children: [
          Column(
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
                child: listAccommodation(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Set<accommodation.Accommodation> filterResult(
      Set<accommodation.Accommodation> accommodation,
      List<Category.Category> requirement) {
    accommodation.retainWhere(
        (element) => filterRequirement(element, requirement) == true);
    return accommodation;
  }

  bool filterRequirement(accommodation.Accommodation accommodation,
      List<Category.Category> requirement) {
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
              icon: icons[index],
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

  listAccommodation() {
    Size size = MediaQuery.of(context).size;
    List<accommodation.Accommodation> filteredaccommodations = accommodations;
    filteredaccommodations = displayByCategory(filteredaccommodations);
    List<Widget> lists = List.generate(
        filteredaccommodations.length,
        (index) => AccommodationItem(
              data: filteredaccommodations[index],
              image: images,
              onTap: () {},
            ));
    return Container(
      height: size.height * 0.52,
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
        child: Column(
          children: lists,
        ),
      ),
    );
  }

  List<accommodation.Accommodation> displayByCategory(
      List<accommodation.Accommodation> filteredaccommodations) {
    switch (selectedCategory) {
      case 1:
        {
          filteredaccommodations = filterResult(
              accommodations.toSet(), [Category.Category.Apartment]).toList();
        }
        break;
      case 2:
        {
          filteredaccommodations = filterResult(
              accommodations.toSet(), [Category.Category.SharedHome]).toList();
        }
        break;
      case 3:
        {
          filteredaccommodations =
              filterResult(accommodations.toSet(), [Category.Category.Hostel])
                  .toList();
        }
        break;
      case 4:
        {
          filteredaccommodations =
              filterResult(accommodations.toSet(), [Category.Category.Hotel])
                  .toList();
        }
        break;
      case 5:
        {
          filteredaccommodations =
              filterResult(accommodations.toSet(), [Category.Category.Homestay])
                  .toList();
        }
        break;
      default:
        break;
    }

    return filteredaccommodations;
  }
}
