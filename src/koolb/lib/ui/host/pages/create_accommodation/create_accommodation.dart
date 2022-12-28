import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/util/load_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateAccommodation extends StatefulWidget {
  String hostID;
  CreateAccommodation({super.key, required this.hostID});

  @override
  State<CreateAccommodation> createState() => _CreateAccommodationState();
}

class _CreateAccommodationState extends State<CreateAccommodation> {
  final List<Category> _categories = [];
  Category _bestDescription = Category.Apartment;
  String? _countryValue;
  String? _cityValue;
  List<String> _cities = <String>[];
  bool _countrySelected = false;
  String? _address;
  int _guests = 1;
  int _children = 0;
  double _price = 10;
  File? _imageFile;
  Uint8List _webImageFile = Uint8List(8);

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _priceController;
  final TextStyle _defaultHeadingStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final _controller = PageController(initialPage: 6);
  final _kDuration = const Duration(milliseconds: 500);
  final _kCurve = Curves.ease;
  final _minPrice = 10.0;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: '$_price');
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _selectingCategory(),
      _selectingLocation(),
      _addBasics(),
      _addAmenities(),
      _addPhotos(),
      _addTitleAndDescription(),
      _addPrice(),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
              effect: const ExpandingDotsEffect(
                dotColor: BlueJean,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Which of these best describes your place?',
          style: _defaultHeadingStyle,
        ),
        _defaultDivider(),
        _cardViewDescription(Icons.apartment, 'Apartment', Category.Apartment),
        _cardViewDescription(Icons.hotel, 'Hotel', Category.Hotel),
        _cardViewDescription(
            Icons.house_siding_outlined, 'Hostel', Category.Hostel),
        _cardViewDescription(Icons.house, 'Homestay', Category.Homestay),
        _cardViewDescription(Icons.people, 'Shared Home', Category.SharedHome),
        _cardViewDescription(
            Icons.location_city, 'Near City', Category.NearCity),
        _cardViewDescription(
            Icons.bedroom_parent, 'Double Room', Category.DoubleRoom),
      ],
    );
  }

  Widget _cardViewDescription(IconData icon, String name, Category category) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Ink(
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
          color: category == _bestDescription
              ? Colors.grey.shade300
              : Colors.white,
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
            padding: const EdgeInsets.all(9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(
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
      controller: _addressController,
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

  Widget _addBasics() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
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

  Widget _addAmenities() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tell guests what your place has to offer',
              style: _defaultHeadingStyle,
            ),
            _defaultDivider(),
            _cardViewAmenities(Icons.breakfast_dining, 'Breakfast Included',
                Category.BreakfastIncluded),
            _cardViewAmenities(Icons.spa, 'Spa', Category.Spa),
            _cardViewAmenities(Icons.pool, 'Pool', Category.Pool),
            _cardViewAmenities(Icons.local_parking_rounded, 'Parking Lot',
                Category.ParkingLot),
            _cardViewAmenities(
                Icons.shield, 'High Safety', Category.HighSafety),
          ],
        ),
      ),
    );
  }

  Widget _cardViewAmenities(IconData icon, String text, Category category) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Ink(
        width: MediaQuery.of(context).size.width - 10,
        decoration: BoxDecoration(
          color: _categories.contains(category)
              ? Colors.grey.shade300
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
          ),
        ),
        child: InkWell(
          splashColor: Colors.grey.shade400,
          onTap: () {
            setState(() {
              if (_categories.contains(category)) {
                _categories.remove(category);
              } else {
                _categories.add(category);
              }
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
                  text,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addPhotos() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add some photos for your tiny home',
          style: _defaultHeadingStyle,
        ),
        _defaultDivider(),
        Expanded(
          child: Center(
            child: Container(
              child: _imageFile == null
                  ? const Text('Select your image')
                  : Container(
                      child: kIsWeb
                          ? Image.memory(
                              _webImageFile,
                              fit: BoxFit.fill,
                            )
                          : Image.file(_imageFile!, fit: BoxFit.fill),
                    ),
            ),
          ),
        ),
        Center(
          child: TextButton(
            onPressed: () async {
              XFile? pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (kIsWeb) {
                var f = await pickedFile?.readAsBytes();
                setState(() {
                  _webImageFile = f!;
                  _imageFile = File('a');
                });
              } else {
                setState(() {
                  if (pickedFile != null) {
                    _imageFile = File(pickedFile.path);
                  }
                });
              }
            },
            child: Text(_imageFile == null
                ? 'Select from library'
                : 'Replace from library'),
          ),
        ),
        if (!kIsWeb)
          Center(
            child: TextButton(
              onPressed: () async {
                XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                setState(() {
                  if (pickedFile != null) {
                    _imageFile = File(pickedFile.path);
                  }
                });
              },
              child: Text(_imageFile == null
                  ? 'Select from camera'
                  : 'Replace from camera'),
            ),
          ),
      ],
    );
  }

  Widget _addTitleAndDescription() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Now, let's give your tiny home a title",
            style: _defaultHeadingStyle,
          ),
          _defaultDivider(),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: TextField(
              controller: _titleController,
              maxLength: 32,
              decoration: const InputDecoration(
                hintText: 'Add your house title here',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
          ),
          Text(
            'Create your description',
            style: _defaultHeadingStyle,
          ),
          _defaultDivider(),
          ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            child: TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              minLines: null,
              maxLines: null,
              maxLength: 500,
              expands: false,
              decoration: const InputDecoration(
                hintText: 'Add your house description here',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //TODO: implement price
  Widget _addPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Now, set your price',
          style: _defaultHeadingStyle,
        ),
        _defaultDivider(),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //button set price
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            splashRadius: 20.0,
                            disabledColor: Colors.grey.shade400,
                            color: Colors.black,
                            onPressed: _price <= _minPrice
                                ? null
                                : () {
                                    setState(() {
                                      _price =
                                          double.parse(_priceController.text);
                                      _price = max(_minPrice, _price - 1);
                                      _priceController.text = '$_price';
                                    });
                                  },
                            icon: const Icon(
                              Icons.remove_circle,
                            ),
                          ),
                          Row(
                            children: [
                              IntrinsicWidth(
                                child: TextField(
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      setState(() {
                                        _price = double.parse(value);
                                      });
                                    }
                                  },
                                  controller: _priceController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                    signed: false,
                                    decimal: true,
                                  ),
                                  decoration: InputDecoration(isDense: true),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const Text('\$'),
                            ],
                          ),
                          IconButton(
                            splashRadius: 20.0,
                            onPressed: () {
                              setState(() {
                                _price = double.parse(_priceController.text);
                                _price += 1;
                                _priceController.text = '$_price';
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Center(
                        child: Text(
                          'per night',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //TODO: validation for each page
}
