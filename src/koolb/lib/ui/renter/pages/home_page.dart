import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
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
}