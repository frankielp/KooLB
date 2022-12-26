import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
<<<<<<< Updated upstream
import 'package:koolb/accommodation/category.dart';
=======
import 'package:koolb/accommodation/category.dart' as Category;
import 'package:koolb/component/category_item.dart';
import 'package:koolb/component/list_accommodation_item.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/wishlist/list_folder_dialog.dart';

>>>>>>> Stashed changes

class HomePage extends StatefulWidget {

  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Home Page')
      ),
    );
  }

  Set<Accommodation> filterResult(Set<Accommodation> accommodation,
      List<Category> requirement) {
    accommodation.retainWhere((element) =>
        filterRequirement(element, requirement) == true);
    return accommodation;
  }

  bool filterRequirement(Accommodation accommodation,
      List<Category> requirement) {
    for (Category categories in requirement) {
      if (!accommodation.category.contains(categories)) return false;
    }
    return true;
  }
<<<<<<< Updated upstream
}
=======

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
    List<Accommodation> filteredaccommodations = accommodations;
    filteredaccommodations = displayByCategory(filteredaccommodations);
    List<Widget> lists = List.generate(
        filteredaccommodations.length,
        (index) => AccommodationItem(
              data: filteredaccommodations[index],
              image: images,
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
>>>>>>> Stashed changes
