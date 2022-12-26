import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/util/load_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateAccommodation extends StatefulWidget {
  CreateAccommodation({super.key});

  @override
  State<CreateAccommodation> createState() => _CreateAccommodationState();
}

class _CreateAccommodationState extends State<CreateAccommodation> {
  List<Category> _categories = [];
  Category _bestDescription = Category.Apartment;
  String? _countryValue;
  String? _cityValue;
  List<String> _cities = <String>[];
  bool _countrySelected = false;
  String? _address;
  int _guests = 1;
  int _children = 0;

  TextEditingController _addressController = TextEditingController();
  static const TextStyle _defaultHeadingStyle = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  final _controller = PageController(initialPage: 2);

  final _kDuration = const Duration(milliseconds: 500);

  final _kCurve = Curves.ease;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _selectingCategory(),
      _selectingLocation(),
      _addBasics(),
      // const SelectingAmenities(),
      // const AddingPhoto(),
      // const SettingTitleDescription(),
      // const SettingPrice(),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                children: pages,
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: pages.length,
              effect: WormEffect(
                dotColor: Colors.grey.shade200,
                activeDotColor: BlueJean,
              ),
            ),
            //Row for navigate button
            rowButton(),
          ],
        ),
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

  Widget _selectingCategory() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Which of these best describes your place?',
            style: _defaultHeadingStyle,
          ),
          _defaultDivider(),
          Expanded(child: _chooseDescription()),
        ],
      ),
    );
  }

  Widget _chooseDescription() {
    return CustomScrollView(
      slivers: [
        SliverGrid.count(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          childAspectRatio: 10 / 2,
          children: [
            _cardViewDescription(
                Icons.apartment, 'Apartment', Category.Apartment),
            _cardViewDescription(Icons.hotel, 'Hotel', Category.Hotel),
            _cardViewDescription(Icons.house, 'Homestay', Category.Homestay),
          ],
        ),
      ],
    );
  }

  Widget _cardViewDescription(IconData icon, String name, Category category) {
    return Ink(
      decoration: BoxDecoration(
        color:
            category == _bestDescription ? Colors.grey.shade300 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
        ),
      ),
      child: InkWell(
        splashColor: Colors.grey.shade400,
        onTap: () {
          setState(() {
            _bestDescription = category;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.black,
                size: 24,
              ),
              Text(
                name,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _defaultDivider() {
    return const Divider(
      color: Colors.black,
      thickness: 0.5,
    );
  }

  Widget _selectingLocation() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Where's your place located?",
            style: _defaultHeadingStyle,
          ),
          _defaultDivider(),
          _selectingCountryAndCity(),
          _addAddress(),
        ],
      ),
    );
  }

  Widget _selectingCountryAndCity() {
    return Row(
      children: [
        Expanded(
          child: DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: "Select a Country",
                labelText: "Country",
              ),
            ),
            selectedItem: _countryValue,
            items: countries,
            onChanged: ((String? value) {
              setState(() {
                _cities = countriesAndCities[value]!;
                _cityValue = null;
                _countrySelected = true;
                _countryValue = value!;
                print(
                    "Selected country: $_countryValue\nCountry selected: $_countrySelected\nCities: $_cities");
              });
            }),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSearchBox: true,
              showSelectedItems: true,
            ),
            selectedItem: _cityValue,
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                hintText: "Select a Cty",
                labelText: "City",
              ),
            ),
            items: _cities,
            onChanged: ((String? value) {
              setState(() {
                _cityValue = value!;
              });
            }),
          ),
        ),
      ],
    );
  }

  Widget _addAddress() {
    return TextFormField(
      initialValue: _address,
      decoration: const InputDecoration(
          hintText: 'Building number, street name, wand, district'),
      validator: (value) {
        if (value == null) {
          var message =
              const SnackBar(content: Text('You must add your address!'));
          ScaffoldMessenger.of(context).showSnackBar(message);
        }
      },
    );
  }

  // bool _validation() {}

  Widget _addBasics() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Share some basics about your place',
            style: _defaultHeadingStyle,
          ),
          _defaultDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Guests',
                  style: TextStyle(fontSize: 18),
                ),
                // guests
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _guests = max(1, _guests - 1);
                            });
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.black,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _guests >= 17 ? '16+' : '$_guests',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _guests = min(17, _guests + 1);
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.black,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Children',
                  style: TextStyle(fontSize: 18),
                ),
                // children
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _children = max(0, _children - 1);
                            });
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.black,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _children >= 17 ? '16+' : '$_children',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _children = min(17, _children + 1);
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            color: Colors.black,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
