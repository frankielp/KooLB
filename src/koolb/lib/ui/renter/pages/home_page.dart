import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart';

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
}