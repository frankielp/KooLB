import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:koolb/accommodation/accommodation.dart';
import 'package:koolb/data/countries_and_cities.dart';
import 'package:koolb/decoration/color.dart';
import 'package:koolb/ui/renter/pages/search/result_search.dart';
import 'package:koolb/util/helper.dart';
import 'package:koolb/util/load_data.dart';
import 'package:location/location.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _numRoomsController =
      TextEditingController(text: '1');
  final TextEditingController _numAdultsController =
      TextEditingController(text: '1');
  final TextEditingController _numChildrenController =
      TextEditingController(text: '0');

  final _formKey = GlobalKey<FormState>();

  late LocationData? _currentPosition;
  Location location = new Location();

  String? countryValue;
  String? cityValue;
  List<String> cities = <String>[];
  bool countrySelected = false;
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  int _numRoom = 1;
  int _numChildren = 1;
  int _numAdults = 0;

  Color dateButtonColor = BlueJean;
  static const defaultDivider = Divider(
    thickness: 0.5,
    color: cyan,
  );

  @override
  Widget build(BuildContext context) {
    //safe screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Accommodation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                // location
                _customDefaultDecoratedContainer(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Where to go?',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      defaultDivider,
                      Row(
                        children: [
                          //Country dropdown
                          Expanded(
                            child: DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                showSelectedItems: true,
                              ),
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "Select a Country",
                                  labelText: "Country",
                                ),
                              ),
                              selectedItem: countryValue,
                              items: countries,
                              onChanged: ((String? value) {
                                setState(() {
                                  cities = countriesAndCities[value]!;
                                  cityValue = null;
                                  countrySelected = true;
                                  countryValue = value!;
                                  print(
                                      "Selected country: $countryValue\nCountry selected: $countrySelected\nCities: $cities");
                                });
                              }),
                            ),
                          ),
                          const SizedBox(
                            width: 50.0,
                          ),
                          Expanded(
                            child: DropdownSearch<String>(
                              popupProps: const PopupProps.menu(
                                showSearchBox: true,
                                showSelectedItems: true,
                              ),
                              selectedItem: cityValue,
                              dropdownDecoratorProps:
                                  const DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  hintText: "Select a Cty",
                                  labelText: "City",
                                ),
                              ),
                              items: cities,
                              onChanged: ((String? value) {
                                setState(() {
                                  cityValue = value!;
                                });
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //when
                _customDefaultDecoratedContainer(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You are here',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    defaultDivider,
                    Row(
                      children: [
                        const Text('From'),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: dateButtonColor),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(DateTime.now().year),
                                lastDate: DateTime(DateTime.now().year + 5));
                            if (picked != null && picked != start) {
                              setState(() {
                                start = picked;
                                if (start.isAfter(end)) {
                                  end = start;
                                }
                              });
                            }
                          },
                          child: Text(dateTimeToString(start)),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        const Text('to'),
                        const SizedBox(
                          width: 15.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: dateButtonColor),
                          onPressed: () async {
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year),
                              lastDate: DateTime(DateTime.now().year + 5),
                            );
                            if (picked != null && picked != end) {
                              end = picked;
                              setState(() {
                                if (end.isAfter(start)) {
                                  dateButtonColor = BlueJean;
                                } else {
                                  dateButtonColor = actionColor;
                                  const snackBar = SnackBar(
                                    content: Text(
                                        'The end day must be after the start day!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                            }
                          },
                          child: Text(dateTimeToString(end)),
                        )
                      ],
                    )
                  ],
                )),
                //room
                _customDefaultDecoratedContainer(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'You need',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    defaultDivider,
                    const SizedBox(
                      height: 0.5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            controller: _numRoomsController,
                            maxLength: 6,
                            textInputAction: TextInputAction.next,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            validator: (value) {
                              return _validator(value, 1);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text('rooms'),
                      ],
                    )
                  ],
                )),
                //Adult
                _customDefaultDecoratedContainer(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'You have',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    defaultDivider,
                    const SizedBox(
                      height: 0.5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                              controller: _numAdultsController,
                              maxLength: 6,
                              textInputAction: TextInputAction.next,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                signed: false,
                                decimal: false,
                              ),
                              validator: (value) {
                                return _validator(value, 1);
                              }),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text('adults'),
                      ],
                    )
                  ],
                )),
                //children
                _customDefaultDecoratedContainer(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'And you go with',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 0.5,
                    ),
                    defaultDivider,
                    const SizedBox(
                      height: 0.5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: TextFormField(
                            maxLength: 6,
                            controller: _numChildrenController,
                            textInputAction: TextInputAction.next,
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            validator: (value) {
                              return _validator(value, 0);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text('children'),
                      ],
                    )
                  ],
                )),
                //search
                ElevatedButton(
                  child: const Text('Search'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final snackBar = SnackBar(
                          content: Text(
                              'Num rooms: ${_numRoomsController.text}, num adults: ${_numAdultsController.text}, num children: ${_numChildrenController.text}'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    _numRoom = int.parse(_numRoomsController.text);
                    _numAdults = int.parse(_numAdultsController.text);
                    _numChildren = int.parse(_numChildrenController.text);
                    List<Accommodation> result = await _getAccommodation();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ResultSearch(resultSearch: result)));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(String? value, int minValue) {
    if (value == null || value.isEmpty) {
      return 'You must fill this.';
    }
    final n = num.parse(value);
    if (n is! int) {
      return 'The number must be an integer';
    }
    if (n < minValue) {
      return 'The number must be greater than $minValue.';
    }
    return null;
  }

  Container _customDefaultDecoratedContainer(Widget child) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0, color: cyan),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }

  Future<List<Accommodation>> _getAccommodation() async {
    List<Accommodation> ret =
        await Accommodation.getAccommodationBasedOnDatabase(
            countryValue!,
            cityValue!,
            int.parse(_numRoomsController.text),
            int.parse(_numAdultsController.text),
            int.parse(_numChildrenController.text),
            start,
            end);

    return ret;
  }

  bool _isDurationAvailable(DateTime start, DateTime end, List<DateTime> starts,
      List<DateTime> ends) {
    int n = starts.length;
    bool ret = true;

    for (int i = 0; i < n; ++i) {
      ret &= ((start.isAfter(starts[i]) && start.isBefore(ends[i])) ||
          (end.isAfter(starts[i]) && end.isBefore(ends[i])));
    }

    return ret;
  }
}
