import 'package:flutter/material.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/host/pages/create_accommodation/adding_photo.dart';
import 'package:koolb/ui/host/pages/create_accommodation/selecting_amenities.dart';
import 'package:koolb/ui/host/pages/create_accommodation/selecting_category.dart';
import 'package:koolb/ui/host/pages/create_accommodation/selecting_location.dart';
import 'package:koolb/ui/host/pages/create_accommodation/setting_basics.dart';
import 'package:koolb/ui/host/pages/create_accommodation/setting_price.dart';
import 'package:koolb/ui/host/pages/create_accommodation/setting_title_description.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateAccommodation extends StatelessWidget {
  CreateAccommodation({super.key});

  final _pages = [
    const SelectingCategory(),
    const SelectingLocation(),
    const SettingBasics(),
    const SelectingAmenities(),
    const AddingPhoto(),
    const SettingTitleDescription(),
    const SettingPrice(),
  ];

  final _controller = PageController(initialPage: 0);
  final _kDuration = const Duration(milliseconds: 500);
  final _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 500,
            child: PageView(
              controller: _controller,
              children: _pages,
            ),
          ),
          SmoothPageIndicator(
            controller: _controller,
            count: _pages.length,
            effect: WormEffect(
              dotColor: Colors.grey.shade200,
              activeDotColor: BlueJean,
            ),
          ),
          //Row for navigate button
          rowButton(),
        ],
      ),
    );
  }

  Widget rowButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          TextButton(
            onPressed: _moveBackPage,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(18.0),
              side: const BorderSide(color: Colors.black, width: 1),
              textStyle: const TextStyle(
                fontSize: 20,
              ),
            ),
            child: const Text(
              'Back',
              style: TextStyle(color: Colors.black),
            ),
          ),
          //next button

          TextButton(
            onPressed: _moveNextPage,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(18.0),
              backgroundColor: Colors.black,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _moveBackPage() {
    _controller.previousPage(duration: _kDuration, curve: _kCurve);
  }

  void _moveNextPage() {
    _controller.nextPage(duration: _kDuration, curve: _kCurve);
  }
}
