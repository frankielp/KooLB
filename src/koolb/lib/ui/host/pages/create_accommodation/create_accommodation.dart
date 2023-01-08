import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/accommodation/category.dart';
import 'package:koolb/data/countries_and_cities.dart';
import 'package:koolb/data/global_data.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/host/pages/create_accommodation/preview.dart';
import 'package:koolb/util/load_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateAccommodation extends StatefulWidget {
  String hostName;
  CreateAccommodation({super.key, required this.hostName});

  @override
  State<CreateAccommodation> createState() => _CreateAccommodationState();
}

class _CreateAccommodationState extends State<CreateAccommodation> {
  //variable of accommodation
  final List<Category> _categories = [];
  Category _bestDescription = Category.Apartment;
  String? _countryValue;
  String? _cityValue;
  List<String> _cities = [];
  bool _countrySelected = false;
  int _guests = 1;
  int _children = 0;
  int _rooms = 1;
  double _price = 10;
  late File? _imageFile = null;
  Uint8List _webImageFile = Uint8List(8);

  //controller
  late TextEditingController _addressController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  final TextStyle _defaultHeadingStyle = const TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  final _controller = PageController(initialPage: _beginPage);
  final _kDuration = const Duration(milliseconds: 500);
  final _kCurve = Curves.ease;
  final _minPrice = 10.0;
  late List<Widget> pages;

  static const int _beginPage = 0;

  int _currentPage = _beginPage;
  String? _message;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: '$_price');

    _titleController = TextEditingController();
    _titleController.addListener(() {
      _verifyPage();
      setState(() {});
    });

    _descriptionController = TextEditingController();
    _descriptionController.addListener(() {
      _verifyPage();
      setState(() {});
    });

    _addressController = TextEditingController();
    _addressController.addListener(() {
      _verifyPage();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    pages = [
      _selectingCategory(),
      _selectingLocation(),
      _addBasics(),
      _addAmenities(),
      _addPhotos(),
      _addTitleAndDescription(),
      _addPrice(),
      _reviewPages(),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: pages,
                ),
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
            _rowButton(),
          ],
        ),
      ),
    );
  }

  Widget _rowButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // back button
          TextButton(
            onPressed: _currentPage == 0 ? null : _moveBackPage,
            style: TextButton.styleFrom(
              backgroundColor:
                  _currentPage == 0 ? Colors.grey.shade500 : Colors.white,
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
            onPressed: _verifyPage()
                ? () {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(_message!)));
                  }
                : _currentPage == pages.length - 1
                    ? _addAccommodationToFirebase
                    : _moveNextPage,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(18.0),
              backgroundColor: _verifyPage() || _currentPage > pages.length - 1
                  ? Colors.grey.shade300
                  : Colors.black,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            child: Text(
              _currentPage < pages.length - 1 ? 'Next' : 'Publish',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _moveBackPage() {
    _controller.previousPage(duration: _kDuration, curve: _kCurve);
    setState(() {
      _currentPage--;
    });
  }

  void _moveNextPage() {
    _controller.nextPage(duration: _kDuration, curve: _kCurve);
    setState(() {
      _currentPage = min(pages.length - 1, _currentPage + 1);
    });
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
    return Column(
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
    );
  }

//bug chọn city khó quá ko sửa nổi
  Widget _selectingCountryAndCity() {
    return Row(
      children: [
        //select country
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
                _cityValue = null;
                _countrySelected = true;
                _countryValue = value!;
                _cities = countriesAndCities[_countryValue]!;
              });
              print(
                  "Selected country: $_countryValue\nCountry selected: $_countrySelected\nCities: ${countriesAndCities[_countryValue]!}");
            }),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        // select city
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Address'),
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
              hintText: 'Building number, street name, wand, district'),
          validator: (value) {
            if (value == null) {
              var message =
                  const SnackBar(content: Text('You must add your address!'));
              ScaffoldMessenger.of(context).showSnackBar(message);
            }
            return null;
          },
        ),
      ],
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
                  'Rooms',
                  style: TextStyle(fontSize: 18),
                ),
                // guests
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _rooms = max(1, _rooms - 1);
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
                      _rooms > 5 ? '5+' : '$_rooms',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _rooms = min(6, _rooms + 1);
                          });
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.black,
                        ))
                  ],
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
                  'Guests',
                  style: TextStyle(fontSize: 18),
                ),
                // guests
                Row(
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
                Row(
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
    // print('Outside\n');
    // print(_imageFile?.path);
    // print(_imageFile == null ? 'No image selected yet' : _webImageFile);
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
            onPressed: kIsWeb
                ? () async {
                    final image = ImagePicker();
                    XFile? tmp =
                        await image.pickImage(source: ImageSource.gallery);
                    var f = await tmp?.readAsBytes();
                    setState(() {
                      _webImageFile = f!;
                      _imageFile = File('a');
                      // print('Inside\n');
                      // print(_imageFile?.path);
                      // print(_imageFile == null
                      //     ? 'No image selected yet'
                      //     : _webImageFile);
                    });
                  }
                : () async {
                    XFile? pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    setState(() {
                      if (pickedFile != null) {
                        _imageFile = File(pickedFile.path);
                      }
                    });
                  },
            // onPressed: () async {
            //   if (kIsWeb) {
            //
            //   } else {
            //
            //   }
            // },
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
                                  decoration:
                                      const InputDecoration(isDense: true),
                                  style: const TextStyle(
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

  //TODO: review pages
  Widget _reviewPages() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review your accommodation',
            style: _defaultHeadingStyle,
          ),
          _defaultDivider(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 50.0,
              shadowColor: Colors.grey.shade500,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: const BorderSide(
                    color: Colors.black,
                    width: 1,
                  )),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => kIsWeb
                          ? PreviewForWeb(
                              image: _webImageFile,
                              title: _titleController.text,
                              hostName: widget.hostName,
                              numAdults: _guests,
                              numChildren: _children,
                              description: _descriptionController.text,
                              address: _addressController.text,
                              city: _cityValue!,
                              country: _countryValue!,
                              price: _price,
                            )
                          : PreviewForMobile(
                              image: _imageFile!,
                              title: _titleController.text,
                              hostName: widget.hostName,
                              numAdults: _guests,
                              numChildren: _children,
                              description: _descriptionController.text,
                              address: _addressController.text,
                              city: _cityValue!,
                              country: _countryValue!,
                              price: _price),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0)),
                            height: MediaQuery.of(context).size.width - 5,
                            width: MediaQuery.of(context).size.width - 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: _imageFile != null
                                  ? (kIsWeb
                                      ? Image.memory(
                                          _webImageFile,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          _imageFile!,
                                          fit: BoxFit.cover,
                                        ))
                                  : Container(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _titleController.text,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('New'),
                                Icon(Icons.star),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: _priceController.text,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300)),
                              const TextSpan(text: '\$ night')
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _verifyPage() {
    switch (_currentPage) {
      case 1:
        _message = _verifyAddressPage();
        break;

      case 4:
        _message = _verifyImagePage();
        break;

      case 5:
        _message = _verifyTitleAndDescription();
        break;

      default:
        _message = null;
    }

    return _message != null;
  }

  String? _verifyAddressPage() {
    if (_countryValue == null) {
      return 'You must choose a country.';
    }
    if (_cityValue == null) {
      return 'You must choose a city.';
    }
    if (_addressController.text.isEmpty) {
      return 'You must enter address.';
    }
    return null;
  }

  String? _verifyImagePage() {
    if (_imageFile == null) {
      return "Please select a image";
    }
    return null;
  }

  String? _verifyTitleAndDescription() {
    if (_titleController.text.isEmpty) {
      return "Please give your accommodation a name.";
    }
    if (_descriptionController.text.isEmpty) {
      return "Pleaser give your accommodation a description.";
    }
    return null;
  }

  Future<void> _addAccommodationToFirebase() async {
    _categories.add(_bestDescription);
    String accommodationID;
    if (kIsWeb) {
      accommodationID = await Accommodation.addAccommodationToFirebaseWeb(
        title: _titleController.text,
        description: _descriptionController.text,
        price: _price,
        address: _addressController.text,
        city: _cityValue!,
        country: _countryValue!,
        categories: _categories,
        webImage: _webImageFile,
        rooms: _rooms,
        adults: _guests,
        children: _children,
        hostId: roleId,
      );
    } else {
      accommodationID = await Accommodation.addAccommodationToFirebaseMobile(
        title: _titleController.text,
        description: _descriptionController.text,
        price: _price,
        address: _addressController.text,
        city: _cityValue!,
        country: _countryValue!,
        categories: _categories,
        mobileImage: _imageFile!,
        rooms: _rooms,
        adults: _guests,
        children: _children,
        hostId: roleId,
      );
    }

    _addAccommodationIdToHost(accommodationID);
    _showAlertDone(accommodationID);
  }

  void _showAlertDone(String accommodationID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Publish successful'),
        content: const Text('Your accommodation is published successfully'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, {
                  'accommodationID': accommodationID,
                });
              },
              child: const Text('Continue')),
        ],
      ),
    );
  }

  void _addAccommodationIdToHost(String accommodationID) async {
    FirebaseFirestore.instance.collection('host').doc(roleId).update({
      'accommodationIds': FieldValue.arrayUnion([accommodationID]),
    });
  }
}
